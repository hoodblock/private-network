# 🚀 PrivateNetwork - iOS 私有 OpenVPN 客户端 (Swift)

PrivateNetwork 是一款基于 Swift 和 OpenVPNAdapter 实现的 iOS VPN 客户端应用，配合 NetworkExtension 框架，提供简洁且安全的 VPN 连接体验

---

📊 界面预览

<h3></h3>
<p align="center">
  <img src="https://github.com/user-attachments/assets/30ae2c8c-0ac5-47d7-8a19-a913390be77e" width="180"/>
  <img src="https://github.com/user-attachments/assets/ef1d78c5-e4be-4687-a26d-9feb91b0b20b" width="180"/>
  <img src="https://github.com/user-attachments/assets/627967c4-07f0-49c8-9ac1-376991cedf02" width="180"/>
  <img src="https://github.com/user-attachments/assets/19725172-ee6e-4196-a631-5430fe3c42d4" width="180"/>
</p>

---

✨ 功能概览

- 🌍 支持多地区节点切换（美国、德国、法国等）
  
- ⚡ 支持一键连接，应用内提示 VPN 状态
  
- 📍 支持查看当前 IP 与定位详情
  
- 📄 完全支持 .ovpn 配置文件
  
- 🛠 基于 OpenVPNAdapter 进行实时连接管理
  
- 📶 支持网页测速功能
  
---

📁 项目结构

PrivateNetwork/

├── App/

  ├── NetworkManager.swift         # 主端 VPN 控制器

  ├── connectfile.ovpn             # 读取 .ovpn 配置

  └── UI/

├── PrivateNetworkExtension/       # 网络扩展

   └── PacketTunnelProvider.swift # NEPacketTunnelProvider

---

🔧 技术实现: OpenVPNAdapter + NetworkExtension

```主 App 点击“连接”  ->  启动 NEPacketTunnelProvider  ->  读取 .ovpn 配置 + 证书  ->  初始化 OpenVPNAdapter  ->  设置 TUN 虚拟网络 + 连接 VPN```

- 主端启动连接

 ```swift
func connectVPN() {
    let manager = NETunnelProviderManager()
    manager.loadFromPreferences { error in
        if error == nil {
            try? manager.connection.startVPNTunnel()
        }
    }
}
```

- 连接逻辑 (VPNExtension)

```swift
class PacketTunnelProvider: NEPacketTunnelProvider {
    private let vpnAdapter = OpenVPNAdapter()
    private var vpnConfig = OpenVPNConfiguration()
    class PacketTunnelProvider: NEPacketTunnelProvider {
    private let vpnAdapter = OpenVPNAdapter()
    private var vpnConfig = OpenVPNConfiguration()
    override func startTunnel(options: [String : NSObject]?, completionHandler: @escaping (Error?) -> Void) {
        vpnAdapter.delegate = self
        guard let ovpn = try? String(contentsOfFile: "/path/to/config.ovpn") else {
            completionHandler(NSError(domain: "config", code: 1))
            return
        }
        do {
            try vpnConfig.apply(ovpnConfiguration: ovpn)
            try vpnAdapter.connect(using: vpnConfig, delegate: self)
        } catch {
            completionHandler(error)
        }
    }
    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        vpnAdapter.disconnect()
        completionHandler()
    }
}
```
- 状态回调 (VPNExtension)

```swift
extension PacketTunnelProvider: OpenVPNAdapterDelegate {
    func openVPNAdapter(_ adapter: OpenVPNAdapter, handle event: OpenVPNAdapterEvent, message: String) {
        switch event {
        case .connected:
            NSLog("VPN connected")
        case .disconnected:
            NSLog("VPN disconnected")
        case .reconnecting:
            NSLog("Reconnecting...")
        default:
            break
        }
    }

    func openVPNAdapter(_ adapter: OpenVPNAdapter, handleError error: Error) {
        NSLog("VPN error: \(error.localizedDescription)")
    }

    func openVPNAdapter(_ adapter: OpenVPNAdapter, configureTunnelWithNetworkSettings settings: NEPacketTunnelNetworkSettings, completionHandler: @escaping (Error?) -> Void) {
        setTunnelNetworkSettings(settings, completionHandler: completionHandler)
    }
}
```

---

🔒 配置文件 (.ovpn)

```swift
client
dev tun
proto udp
remote SERVICE_IP_PORT
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
auth SHA512
cipher AES-256-CBC
ignore-unknown-option block-outside-dns
verb 3
<ca>
-----BEGIN CERTIFICATE-----
MIIDSzCCAjOgAwIBAgIUSqVHl0SUhehFBM2mflJLdEILXDUwDQYJKoZIhvcNAQEL
dnFo6tkozdt4OPExcdFFwF9HX0cZZEL0N01uHFi2Sw==
-----END CERTIFICATE-----
</ca>
<cert>
-----BEGIN CERTIFICATE-----
MIIDXDCCAkSgAwIBAgIRAJnzaVZDLaC3z7bai8Z3wGswDQYJKoZIhvcNAQELBQAw
mNPyG47AqwrpivX3kGLahmuxZ9aXS4LfqYmt7QK9NFLnH5RSnXKR7TXSpulnhYws
-----END CERTIFICATE-----
</cert>
<key>
-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC9849CR8nzq04R
xSWwrOIk3ql7tPo+arw1RTz+
-----END PRIVATE KEY-----
</key>
<tls-crypt>
-----BEGIN OpenVPN Static key V1-----
9f0d2eb1cf5bdf4b4a54c3f56774e350
-----END OpenVPN Static key V1-----
</tls-crypt>

```
.ovpn 文件的内容通常包括:
 - client:声明这是一个客户端配置文件。
 - dev tun:指定使用TUN 虚拟网络接口（也可以是TAP）。
 - proto udp 或 proto tcp:指定使用UDP 或TCP 协议。
 - remote:指定OpenVPN 服务器的地址和端口，例如 remote vpn.example.com 1194。
 - ca:指定根证书的路径。
 - cert:指定客户端证书的路径。
 - key:指定客户端密钥的路径。
 - tls-auth:指定TLS 认证密钥的路径（如果启用）。
 - cipher:指定加密算法，例如 AES-256-CBC。
 - auth:指定认证算法，例如 SHA256。
 - persist-key:保持密钥，避免每次连接都重新加载。
 - persist-tun:保持TUN/TAP 设备，避免每次连接都重新配置。
 - verb 3:设置日志详细级别。

---

⛓️ 安全性

- 配置仅保存于本地

- 没有数据云端上传

- 推荐使用自签 TLS 证书和 CA

---


