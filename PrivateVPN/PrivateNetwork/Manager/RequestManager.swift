//
//  RequestManager.swift
//  PrivateNetwork
//
//  Created by Thomas on 2024/9/19.
//

import UIKit


class RegionItem {
    var regionIconCodeName: String?
    var regionIcon: String?
    var regionCountry: String?
    var regionCountryCode: String?
    var regionCity: String?
    var regionIP: String?
    var regionLimit: Bool = false
    var regionLon: String = String()
    var regionLat: String = String()
    var regionPortItemString: String?
    var regionSelected: Bool = false
    var regioncCollected: Bool = false
    var regionIsVIP: Bool = false
    var regionHidePing: CGFloat = 0.00
    var regionPing: CGFloat = 0.00
    var regionTimeout: NSInteger = 5000
    var regionWeight: NSInteger = 1
    var regionPortItems: [String] {
        get {
            return regionPortItemString?.components(separatedBy: ",") ?? []
        }
    }
    var regionConnectTime: CLongLong = 1
    /// ping工具模型
    var ddPingTool: DDPingTools = DDPingTools()
}

let userdefaultLocalAddress = "userdefault_local_region_address"
let userdefaultLocalCountryCode = "userdefault_local_region_countrycode"
let userdefaultLocalUser = "userdefault_local_region_user"

let REGION_LIST_URL = "https://api.top/"
let REGION_IP_URL = "http://ip-api.com/json"
let REGION_AD_URL = "https://api.top/"
let REGION_CONNECT_URL = "https://api.top/"


class RequestManager {
    static let shared = RequestManager()
    
    var currentRegionItem: RegionItem = RegionItem()

    var currentSelectedRegionItem: RegionItem {
        get {
            return regionItems.first(where: { $0.regionSelected }) ?? regionItems[0]
        }
        set {
            regionItems.forEach { $0.regionSelected = false }
            regionItems.first(where: { $0.regionIP == newValue.regionIP })?.regionSelected = true
        }
    }
    
    private var localUser: String {
        get {
            return UserDefaults.standard.string(forKey: userdefaultLocalUser) ?? UUID().uuidString
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: userdefaultLocalUser)
        }
    }

    private var localAddress: String {
        get {
            return UserDefaults.standard.string(forKey: userdefaultLocalAddress) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: userdefaultLocalAddress)
        }
    }

    private var localCountryCode: String {
        get {
            return UserDefaults.standard.string(forKey: userdefaultLocalCountryCode) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: userdefaultLocalCountryCode)
        }
    }

    init() {
        //  初始化本地数据
        updateCountryIcon()
        // 更新数据列表状态
        updateListData()
    }
    
    lazy var regionItems: [RegionItem] = {
        let defaultRegions = [
            ("Los Angel", "United States", "1194", "74.48.33.94", "US_LosAngel United States"),
            ("Spokane", "United States", "1194", "199.119.138.198", "US_Spokane United States"),
            ("Buffalo", "United States", "1194", "23.94.182.57", "US_Buffalo United States"),
            ("Falkenstein", "Germany", "1194", "23.165.200.83", "DE_Falkenstein"),
            ("Strasbourg", "France", "1194", "45.95.172.108", "FR_Strasbourg France")
        ]
        
        return defaultRegions.map { city, country, port, ip, icon in
            let item = RegionItem()
            item.regionCity = city
            item.regionCountry = country
            item.regionPortItemString = port
            item.regionIP = ip
            item.regionIconCodeName = icon
            item.regionSelected = (city == "Los Angel")
            return item
        }
    }()

    /// 更新国家信息
    func updateCountryIcon() {
        for item in regionItems {
            let array: [String] = item.regionIconCodeName?.components(separatedBy: "_") ?? [String]()
            if array.count > 1 {
                let countryCode: String = array[0].lowercased()
                if UIImage(named: "country_\(countryCode)_icon") != nil {
                    item.regionIcon = "country_\(countryCode)_icon"
                } else {
                    item.regionIcon = "country_default_icon"
                }
            } else {
                item.regionIcon = "country_default_icon"
            }
            item.regionSelected = false
            item.regionHidePing = 1000
            if item.regionIP == localAddress {
                item.regionSelected = true
            }
        }
    }
    
    /// 更新列表数据
    func updateListData() {
        let array = regionItems.filter( {$0.regionSelected == true})
        if array.count == 0 {
            regionItems[0].regionSelected = true
        }
    }

    // 刷新
    func updatePing(result: @escaping () -> Void) {
        for item in regionItems {
            DispatchQueue.main.async {
                item.ddPingTool = DDPingTools(hostName: item.regionIP)
                item.ddPingTool.debugLog = false
                item.ddPingTool.start(pingType: .any, interval: .second(0)) { (response, error) in
                    print("ping: _______ ip: \(String(describing: item.regionIP)) country: \(String(describing: item.regionCountry)) city: \(String(describing: item.regionCity)) number: \(String(describing: response?.responseTime.second)) error: \(String(describing: error))")
                    item.regionHidePing = RequestManager.formatToTwoDecimalPlacesAndConvertToCGFloat(response?.responseTime.second)
               }
            }
        }
        // 取出 regionHidePing最小的数
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            let sortedHidePingModels = self?.regionItems.sorted { $0.regionHidePing < $1.regionHidePing }
            let sortedWeightModels = self?.regionItems.sorted { $0.regionWeight > $1.regionWeight }
            for sortedWeightModel in sortedWeightModels ?? [] {
                if sortedWeightModel.regionWeight != 1 {
                    if sortedHidePingModels?[0].regionHidePing ?? 1000 > 30 {
                        sortedWeightModel.regionPing = (sortedHidePingModels?[0].regionHidePing ?? 1000) - CGFloat(sortedWeightModel.regionWeight * 2)
                    } else if sortedHidePingModels?[0].regionHidePing ?? 1000 > 20 {
                        sortedWeightModel.regionPing = (sortedHidePingModels?[0].regionHidePing ?? 1000) - CGFloat(sortedWeightModel.regionWeight * 2)
                    } else {
                        sortedWeightModel.regionPing = (sortedHidePingModels?[0].regionHidePing ?? 1000) - CGFloat(sortedWeightModel.regionWeight * 2)
                    }
                } else {
                    sortedWeightModel.regionPing = sortedWeightModel.regionHidePing
                }
            }
            self?.regionItems = sortedWeightModels ?? []
            self?.regionItems = self?.regionItems.sorted { $0.regionPing < $1.regionPing } ?? []
            self?.updateListData()
            result()
        }
    }
 
}


// MARK: - 接口信息
extension RequestManager {
 
    /// 请求当前正在使用地址的详细数据
    func fetchRegionDetail(success: @escaping () -> Void, failure: @escaping () -> Void) {
        let request = URLRequest(url: URL(string: REGION_IP_URL)!)
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard error == nil else {
                failure()
                return
            }
            guard let data = data else {
                failure()
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let currentRegionItem = RegionItem()
                    currentRegionItem.regionCity = json["regionName"] as? String
                    currentRegionItem.regionCountry = json["country"] as? String
                    currentRegionItem.regionLat = String(format: "%0.2f", json["lat"] as? CGFloat ?? 0.00)
                    currentRegionItem.regionIP = json["query"] as? String
                    currentRegionItem.regionLon = String(format: "%0.2f", json["lon"] as? CGFloat ?? 0.00)
                    currentRegionItem.regionCountryCode = json["countryCode"] as? String
                    currentRegionItem.regionIcon = "country_\(currentRegionItem.regionCountryCode?.lowercased() ?? "")_icon"
//                    currentRegionItem.regionLimit = (currentRegionItem.regionCountry?.uppercased().contains("CHINA") ?? false ||
//                                                     currentRegionItem.regionCountryCode?.contains("CN") ?? false)
                    currentRegionItem.regionLimit = false
                    self?.currentRegionItem = currentRegionItem
                }
                success()
            } catch {
                failure()
            }
        }
        dataTask.resume()
    }
    
    
    /// 请求能够连接的地址列表
    func fetchRegionList(success: @escaping () -> Void, failure: @escaping () -> Void) {
        let requestDic: [String: Any] = [
            "userId": localUser,
            "appId": "",
            "sysVer": Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String,
            "appVer": UIDevice.current.systemVersion,
            "countryCode": localCountryCode,
            "data": ["localTime": RequestManager.newTimeFromFormat("yyyy-MM-dd HH:mm:ss")]
        ]

        if let requestData = try? JSONSerialization.data(withJSONObject: requestDic, options: .sortedKeys) {
            if let zipData = try? requestData.gzipped() {
                let encryptedData = Data(bytes: DataEncryptTool.encryptionData(zipData), count: zipData.count)
                var request = URLRequest(url: URL(string: REGION_LIST_URL)!)
                request.httpMethod = "POST"
                request.httpBody = encryptedData

                let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                    guard error == nil, let data = data else {
                        self?.updateCountryIcon()
                        self?.updatePing(result: {
                        })
                        self?.updateListData()
                        failure()
                        return
                    }
                    do {
                        if let json = try JSONSerialization.jsonObject(with: DataEncryptTool.dencryptionData(data).gunzipped(), options: []) as? [String: Any],
                           let data = json["data"] as? [[String: Any]] {
                            self?.regionItems = data.compactMap { itemDict -> RegionItem? in
                                let regionItem = RegionItem()
                                regionItem.regionCountry = itemDict["country"] as? String
                                regionItem.regionPortItemString = itemDict["port"] as? String
                                regionItem.regionWeight = itemDict["weight"] as? Int ?? 1
                                regionItem.regionTimeout = itemDict["timeout"] as? Int ?? 5000
                                regionItem.regionIP = itemDict["ip"] as? String
                                regionItem.regionIconCodeName = itemDict["name"] as? String
                                regionItem.regionCity = itemDict["city"] as? String
                                return regionItem
                            }
                            self?.updateCountryIcon()
                            self?.updatePing(result: {
                            })
                            self?.updateListData()
                        }
                        success()
                    } catch {
                        self?.updateCountryIcon()
                        self?.updatePing(result: {
                        })
                        self?.updateListData()
                        failure()
                    }
                }
                dataTask.resume()
            }
        }
    }
    
    /// 上报 连接记录
    func updateConnectAction(_ port: [String], success: @escaping () -> Void, failure: @escaping () -> Void) {
        let requestDic: [String: Any] = [
            "userId": localUser,
            "appId": "",
            "sysVer": Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String,
            "appVer": UIDevice.current.systemVersion,
            "countryCode": localCountryCode,
            "data": [
                "localTime": RequestManager.newTimeFromFormat("yyyy-MM-dd HH:mm:ss"),
                "connectInfo": port.enumerated().map { index, port in
                    [
                        "ip": currentSelectedRegionItem.regionIP ?? "",
                        "port": port,
                        "ping": String(format: "%0.2f", currentSelectedRegionItem.regionHidePing),
                        "status": (NetworkManager.shared.status == .connected && index == port.count - 1) ? "1" : "0",
                        "connectTime": String(format: "%d", (NetworkManager.shared.status == .connected) ? RequestManager.nowTime(true) - UInt64(currentSelectedRegionItem.regionConnectTime) : 0)
                    ]
                }
            ]
        ]

        if let requestData = try? JSONSerialization.data(withJSONObject: requestDic, options: .sortedKeys) {
            if let zipData = try? requestData.gzipped() {
                let encryptedData = Data(bytes: DataEncryptTool.encryptionData(zipData), count: zipData.count)
                var request = URLRequest(url: URL(string: REGION_CONNECT_URL)!)
                request.httpMethod = "POST"
                request.httpBody = encryptedData

                let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                }
                dataTask.resume()
            }
        }
    }
}


// MARK: - 时间扩展
extension RequestManager {
    
    static func nowTime(_ isms: Bool = false) -> UInt64 {
        return UInt64(Date().timeIntervalSince1970) * (isms ? 1000 : 1)
    }

    static func newTimeFromFormat(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }

    static func formatToTwoDecimalPlacesAndConvertToCGFloat(_ number: Double?) -> CGFloat {
        if number == nil {
            return CGFloat((number ?? 1000.0).rounded(toPlaces: 2))
        } else if (number ?? 0.00) < 1.00 {
            return CGFloat(((number ?? 0.00) * 1000.00).rounded(toPlaces: 2))
        } else {
            return CGFloat((number ?? 1000.0).rounded(toPlaces: 2))
        }
    }
    
}


// MARK: - 随机数扩展
extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        let dajdusa: Double = (self * divisor).rounded() / divisor
        return dajdusa
    }
}
