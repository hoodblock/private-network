//
//  HistoryManager.swift
//  V608
//
//  Created by Thomas on 2024/12/5.
//

import Foundation

class HistoryManager {
    
    static let shared = HistoryManager()
    
    var regionItems: [RegionItem] = []
    var collectItems: [CollectItem] = []

    // UserDefaults 的 key
    private let itemsKey = "historyCollectItems"
    
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
                collectItems = decodedItems
                regionItems = []
                for item in collectItems {
                    regionItems.append(changeItemForCollectItem(collectItem: item))
                }
            } catch {
                print("Error decoding items: \(error)")
            }
        }
    }
    
    // 保存 CollectItem 数组到 UserDefaults
    private func saveItems() {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(collectItems)
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
            UserDefaults.standard.synchronize()
        } catch {
            print("Error encoding items: \(error)")
        }
    }
    
    func addItem(regionItem: RegionItem) {
        collectItems.append(changeItemForRegionItem(regionItem: regionItem))
        regionItems.append(regionItem)
        saveItems()
    }
    
    func changeItemForRegionItem(regionItem: RegionItem) -> CollectItem {
        let collectItem: CollectItem = CollectItem()
        collectItem.regionIconCodeName = regionItem.regionIconCodeName
        collectItem.regionIcon = regionItem.regionIcon
        collectItem.regionCountry = regionItem.regionCountry
        collectItem.regionCountryCode = regionItem.regionCountryCode
        collectItem.regionCity = regionItem.regionCity
        collectItem.regionIP = regionItem.regionIP
        collectItem.regionLimit = regionItem.regionLimit
        collectItem.regionLon = regionItem.regionLon
        collectItem.regionLat = regionItem.regionLat
        collectItem.regionPortItemString = regionItem.regionPortItemString
        collectItem.regionSelected = regionItem.regionSelected
        collectItem.regioncCollected = regionItem.regioncCollected
        collectItem.regionHidePing = regionItem.regionHidePing
        collectItem.regionPing = regionItem.regionPing
        collectItem.regionTimeout = regionItem.regionTimeout
        collectItem.regionWeight = regionItem.regionWeight
        collectItem.regionConnectTime = regionItem.regionConnectTime
        return collectItem
    }
    
    func changeItemForCollectItem(collectItem: CollectItem) -> RegionItem {
        let regionItem: RegionItem = RegionItem()
        regionItem.regionIconCodeName = collectItem.regionIconCodeName
        regionItem.regionIcon = collectItem.regionIcon
        regionItem.regionCountry = collectItem.regionCountry
        regionItem.regionCountryCode = collectItem.regionCountryCode
        regionItem.regionCity = collectItem.regionCity
        regionItem.regionIP = collectItem.regionIP
        regionItem.regionLimit = collectItem.regionLimit
        regionItem.regionLon = collectItem.regionLon
        regionItem.regionLat = collectItem.regionLat
        regionItem.regionPortItemString = collectItem.regionPortItemString
        regionItem.regionSelected = collectItem.regionSelected
        regionItem.regioncCollected = collectItem.regioncCollected
        regionItem.regionHidePing = collectItem.regionHidePing
        regionItem.regionPing = collectItem.regionPing
        regionItem.regionTimeout = collectItem.regionTimeout
        regionItem.regionWeight = collectItem.regionWeight
        regionItem.regionConnectTime = collectItem.regionConnectTime
        return regionItem
    }
}
