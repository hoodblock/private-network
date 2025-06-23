//
//  SubscriptionConfig.swift
//  V608
//
//  Created by Thomas on 2024/9/14.
//

import Foundation

enum SubscripType {
    case none
    case day
    case week
    case month
    case quarter
    case year
    case forever
}

class SubscriptionConfig {
    
    static let shared = SubscriptionConfig()
    
    /// 订阅类型
    var subscriptType: SubscripType = .none
    
    init () {
        
    }
    
    func isPaied() -> Bool {
        return false
    }
}
