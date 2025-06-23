//
//  CollectManager.swift
//  PrivateNetwork
//
//  Created by Thomas on 2024/12/5.
//

import Foundation


/**
 *
 * 收藏数据多，先保存数据，然后获取的数据和当前服务器数据比较，然后再把收藏开关打开
 *
 */

class CollectItem: Encodable, Decodable {
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
    var regionHistoryConnectTime: CLongLong = 1
}


class CollectManager {
    
    static let shared = CollectManager()
    
    var items: [CollectItem] = []
    
    // UserDefaults 的 key
    private let itemsKey = "collectItems"
    
    init() {
        // 初始化时从 UserDefaults 加载数据
        loadItems()
    }
    
    // 从 UserDefaults 加载 CollectItem 数组
    private func loadItems() {
        if let data = UserDefaults.standard.data(forKey: itemsKey) {
            let decoder = JSONDecoder()
            do {
                let decodedItems = try decoder.decode([CollectItem].self, from: data)
                items = decodedItems
            } catch {
                print("Error decoding items: \(error)")
            }
        }
    }
    
    // 保存 CollectItem 数组到 UserDefaults
    private func saveItems() {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(items)
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
            UserDefaults.standard.synchronize()
        } catch {
            print("Error encoding items: \(error)")
        }
    }
}

extension CollectManager {
    
    // 更新地区数据，把收藏列表的值赋值到地区列表中，使用时使用地区列表
    func updateRegionItemCollect() {
        for index in 0..<RequestManager.shared.regionItems.count {
            if items.contains(where: { $0.regionIP == RequestManager.shared.regionItems[index].regionIP }) {
                RequestManager.shared.regionItems[index].regioncCollected = true
            }
        }
        updateCollect()
    }
    
    // 当点击收藏按钮时，要更新数据
    func updateCollect() {
        let regionCollectItems = RequestManager.shared.regionItems.filter( {$0.regioncCollected == true})
        items = []
        for item in regionCollectItems {
            let collectItem = CollectItem()
            collectItem.regionIP = item.regionIP
            items.append(collectItem)
        }
        saveItems()
    }
    
}
