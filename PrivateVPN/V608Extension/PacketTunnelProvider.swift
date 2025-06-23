//
//  PacketTunnelProvider.swift
//  V608Extension
//
//  Created by Thomas on 2024/12/6.
//

import NetworkExtension
import OpenVPNAdapter

extension NEPacketTunnelFlow: @retroactive OpenVPNAdapterPacketFlow {}

class PacketTunnelProvider: NEPacketTunnelProvider {

    lazy var vpnAdapter: OpenVPNAdapter = {
        let adapter = OpenVPNAdapter()
        adapter.delegate = self
        return adapter
    }()

    let vpnReachability = OpenVPNReachability()

    var startHandler: ((Error?) -> Void)?
    var stopHandler: (() -> Void)?

    override func startTunnel(options: [String : NSObject]?, completionHandler: @escaping (Error?) -> Void) {
        guard
            let protocolConfiguration = protocolConfiguration as? NETunnelProviderProtocol,
            let providerConfiguration = protocolConfiguration.providerConfiguration
        else {
            fatalError()
        }
        
        guard let ovpnFileContent: Data = providerConfiguration["ovpn"] as? Data else {
            fatalError()
        }

        let configuration = OpenVPNConfiguration()
        configuration.fileContent = ovpnFileContent
//        configuration.settings = []


        do {
            _ = try vpnAdapter.apply(configuration: configuration)
        } catch {
            completionHandler(error)
            return
        }


//         Provide credentials if needed
//            // If your VPN configuration requires user credentials you can provide them by
//            // `protocolConfiguration.username` and `protocolConfiguration.passwordReference`
//            // properties. It is recommended to use persistent keychain reference to a keychain
//            // item containing the password.
//
//            guard let username: String = protocolConfiguration.username else {
//                fatalError()
//            }
//
//            // Retrieve a password from the keychain
//            guard let password: String = ... {
//                fatalError()
//            }
//
//            let credentials = OpenVPNCredentials()
//            credentials.username = username
//            credentials.password = password
//
//            do {
//                try vpnAdapter.provide(credentials: credentials)
//            } catch {
//                completionHandler(error)
//                return
//            }
        // Checking reachability. In some cases after switching from cellular to
        // WiFi the adapter still uses cellular data. Changing reachability forces
        // reconnection so the adapter will use actual connection.
        vpnReachability.startTracking { [weak self] status in
            guard status == .reachableViaWiFi else {
                return
            }
            self?.vpnAdapter.reconnect(afterTimeInterval: 5)
        }
        // Establish connection and wait for .connected event
        startHandler = completionHandler
        vpnAdapter.connect(using: packetFlow)
    }




    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        stopHandler = completionHandler
        if vpnReachability.isTracking {
            vpnReachability.stopTracking()
        }
        vpnAdapter.disconnect()
    }
}




extension PacketTunnelProvider: OpenVPNAdapterDelegate {


    func openVPNAdapter(_ openVPNAdapter: OpenVPNAdapter, configureTunnelWithNetworkSettings networkSettings: NEPacketTunnelNetworkSettings?, completionHandler: @escaping ((any Error)?) -> Void) {
        networkSettings?.dnsSettings?.matchDomains = [""]
        setTunnelNetworkSettings(networkSettings) { error in
            completionHandler(error)
        }
    }


    func openVPNAdapter(_ openVPNAdapter: OpenVPNAdapter, handleEvent event: OpenVPNAdapterEvent, message: String?) {
        switch event {
        case .connected:
            if reasserting {
                reasserting = false
            }
            guard let startHandler = startHandler else { return }
            startHandler(nil)
            self.startHandler = nil
        case .disconnected:
            guard let stopHandler = stopHandler else { return }
            if vpnReachability.isTracking {
                vpnReachability.stopTracking()
            }
            stopHandler()
            self.stopHandler = nil
        case .reconnecting:
            reasserting = true
        default:
            break
        }
    }


    func openVPNAdapter(_ openVPNAdapter: OpenVPNAdapter, handleError error: Error) {
        guard let fatal = (error as NSError).userInfo[OpenVPNAdapterErrorFatalKey] as? Bool, fatal == true else { return }
        if vpnReachability.isTracking {
            vpnReachability.stopTracking()
        }
        if let startHandler = startHandler {
            startHandler(error)
            self.startHandler = nil
        } else {
            cancelTunnelWithError(error)
        }
    }




    // Use this method to process any log message returned by OpenVPN library.
    func openVPNAdapter(_ openVPNAdapter: OpenVPNAdapter, handleLogMessage logMessage: String) {
        // Handle log messages
    }




}
