//
//  NetworkManager.swift
//  V608
//
//  Created by Thomas on 2024/9/19.
//

import NetworkExtension
import UIKit
import BackgroundTasks

extension Notification.Name {
    static let freeTimeNotification = Notification.Name("com.example.app.freeTimenotification")
}

let vpnIdentifier = "com.subfg.extension"
let vpnDisplayName = "PrivateVPN: Easy & Fast Proxy"
let connectTimeKey = "connect_time"
let connectStatusKey = "connect_status"
let configKey = "local_config"
let userdefault_free_time = "userdefault_free_time"
let userdefault_free_time_status = "userdefault_free_time_status"

 
typealias ConfigCompletion = (_ success: Bool) -> Void
typealias ConnectCompletion = (_ success: Bool) -> Void

class NetworkManager {

    static let shared = NetworkManager()

    private var tunnelManager: NETunnelProviderManager = NETunnelProviderManager()
    private var serverAddress: String = ""
    private var serverPort: String = ""
    private var connectCompletion: ConnectCompletion?
    private var configCompletion: ConfigCompletion?

    
    // 免费时长， 60分钟， 3600秒
    private var freeTimeMins: Int = 3600
    private var timer: Timer?

    var status: NEVPNStatus {
        if tunnelManager.connection.status != .connected {
            UserDefaults.standard.setValue(0, forKey: connectTimeKey)
            UserDefaults.standard.synchronize()
        }
        return tunnelManager.connection.status
    }

    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleStatusChange), name: .NEVPNStatusDidChange, object: nil)
        loadPreferences()
        self.freeTimeMins = UserDefaults.standard.integer(forKey: userdefault_free_time)
        if !UserDefaults.standard.bool(forKey: userdefault_free_time_status) {
            self.freeTimeMins = 3600
        }
    }

    private func loadPreferences() {
        NETunnelProviderManager.loadAllFromPreferences { [weak self] (managers, error) in
            guard let self = self, error == nil, let managers = managers, !managers.isEmpty else { return }
            if managers[0].localizedDescription == vpnDisplayName {
                self.tunnelManager = managers[0]
                UserDefaults.standard.setValue(false, forKey: configKey)
                UserDefaults.standard.synchronize()
            }
        }
    }

    func configure(withIP ip: String, port: String, completion: @escaping ConfigCompletion) {
        configCompletion = completion
        serverAddress = ip
        serverPort = port
        loadConfig()
    }

    func start(withIP ip: String, port: String, completion: @escaping ConnectCompletion) {
        connectCompletion = completion
        serverAddress = ip
        serverPort = port
        loadConfig(isSystem: true)
    }

    func stop(completion: @escaping ConnectCompletion) {
        connectCompletion = completion
        UserDefaults.standard.setValue(NetworkManager.currentTime(), forKey: connectTimeKey)
        UserDefaults.standard.synchronize()
        tunnelManager.connection.stopVPNTunnel()
        connectCompletion?(false)
    }

    private func loadConfig(isSystem: Bool = false) {
        NETunnelProviderManager.loadAllFromPreferences { [weak self] (managers, error) in
            guard let self = self, error == nil else {
                self?.tunnelManager.localizedDescription = ""
                self?.configCompletion?(false)
                return
            }
            self.tunnelManager = managers?.first ?? NETunnelProviderManager()
            let providerProtocol = NETunnelProviderProtocol()
            providerProtocol.providerBundleIdentifier = vpnIdentifier
            providerProtocol.disconnectOnSleep = false
            
            let configString = self.loadConfigString()
            providerProtocol.providerConfiguration = ["open": configString?.data(using: .utf8) ?? Data()]
            providerProtocol.serverAddress = self.serverAddress
            
            self.tunnelManager.protocolConfiguration = providerProtocol
            self.tunnelManager.localizedDescription = vpnDisplayName
            self.tunnelManager.isEnabled = true
            
            self.tunnelManager.saveToPreferences { [weak self] (error) in
                guard let self = self, error == nil else {
                    self?.tunnelManager.localizedDescription = ""
                    self?.configCompletion?(false)
                    return
                }
                self.tunnelManager.loadFromPreferences { (error) in
                    if isSystem {
                        self.connect()
                    } else {
                        self.configCompletion?(true)
                    }
                }
            }
        }
    }

    private func loadConfigString() -> String? {
        do {
            let url = Bundle.main.url(forResource: "connectfile", withExtension: "ovpn")
            let data = try Data(contentsOf: url!)
            var configString = String(data: data, encoding: .utf8)
            configString = configString?.replacingOccurrences(of: "SERVICE_IP_PORT", with: "\(serverAddress) \(serverPort)")
            return configString
        } catch {
            return nil
        }
    }

    private func connect() {
        if tunnelManager.connection.status == .disconnected {
            tunnelManager.loadFromPreferences { [weak self] (error) in
                guard let self = self, error == nil else { return }
                do {
                    try self.tunnelManager.connection.startVPNTunnel()
                } catch {
                    // Handle error
                }
            }
        } else if tunnelManager.connection.status == .connecting {
            tunnelManager.connection.stopVPNTunnel()
        }
    }

    @objc private func handleStatusChange(notification: Notification) {
        switch tunnelManager.connection.status {
        case .connected:
            UserDefaults.standard.setValue(0, forKey: connectTimeKey)
            UserDefaults.standard.synchronize()
            connectCompletion?(true)
            startTimer()
        case .disconnected, .disconnecting, .invalid :
            timer?.invalidate()
            timer = nil
        default:
            break
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: connectStatusKey), object: nil)
    }

    static func currentTime(inMilliseconds: Bool = false) -> UInt64 {
        let date = Date()
        return inMilliseconds ? UInt64(date.timeIntervalSince1970 * 1000) : UInt64(date.timeIntervalSince1970)
    }
    
    func systemOpen() -> Bool {
        return false
    }
}

extension NetworkManager {
    
    /// 前台定时器：每秒执行一次
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(executeTask), userInfo: nil, repeats: true)
    }

    @objc func executeTask() {
        self.freeTimeMins -= 1
        if self.freeTimeMins <= 0 {
            timer?.invalidate()
            timer = nil
            self.freeTimeMins = 0
        }
        UserDefaults.standard.setValue(self.freeTimeMins, forKey: userdefault_free_time)
        UserDefaults.standard.synchronize()
        UserDefaults.standard.setValue(true, forKey: userdefault_free_time_status)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: .freeTimeNotification, object: nil)
    }

    /// 添加免费时长 (mins))
    func addFreeTime(times: Int) {
        self.freeTimeMins += (times * 60)
        UserDefaults.standard.setValue(self.freeTimeMins, forKey: userdefault_free_time)
        UserDefaults.standard.synchronize()
        UserDefaults.standard.setValue(true, forKey: userdefault_free_time_status)
        UserDefaults.standard.synchronize()
    }
    
    /// 剩余多长时间
    func formatTime() -> String {
        if freeTimeMins == 0 {
            return String(format: "00:00:00")
        }
        let hours = freeTimeMins / 3600
        let minutes = (freeTimeMins % 3600) / 60
        let secondsRemaining = freeTimeMins % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, secondsRemaining)
    }
}




