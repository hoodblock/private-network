//
//  DataEncryptTool.swift
//  V608
//
//  Created by Thomas on 2024/9/19.
//

import Foundation


let ENCRYPT: Int = 1
let DECRYPT: Int = -1
let SECRET_KEY: String = "xxx.top"

class DataEncryptTool {
    
    // 加密
    static func encryptionInt8(_ jsonString: String?) -> [Int8] {
        guard let jsonData = jsonString?.data(using: .utf8) else {
            return []
        }
        
        let jsonUint = [UInt8](jsonData)
        guard let keyData = SECRET_KEY.data(using: .utf8) else {
            return []
        }
        
        let keyUint = [UInt8](keyData)
        var successUint = [Int8](repeating: 0, count: jsonData.count)
        
        for index in 0..<jsonData.count {
            let successByte = encryptionByte(jsonUint[index], key: keyUint[index % keyData.count], method: ENCRYPT)
            successUint[index] = Int8(successByte)
        }
        
        return successUint
    }
    
    static func encryptionString(_ jsonString: String?) -> [UInt8] {
        guard let jsonData = jsonString?.data(using: .utf8) else {
            return []
        }
        
        let jsonUint = [UInt8](jsonData)
        guard let keyData = SECRET_KEY.data(using: .utf8) else {
            return []
        }
        
        let keyUint = [UInt8](keyData)
        var successUint = [UInt8](repeating: 0, count: jsonData.count)
        
        for index in 0..<jsonData.count {
            let successByte = encryptionByte(jsonUint[index], key: keyUint[index % keyData.count], method: ENCRYPT)
            successUint[index] = UInt8(bitPattern: Int8(successByte))
        }
        
        return successUint
    }
    
    static  func encryptionByte(_ msg: UInt8, key: UInt8, method: Int) -> Int8 {
        var subKey = Int(key % 8)
        subKey = method * subKey
        subKey = (subKey >= 0 ? subKey : subKey + 8)
        
        var nMsg = Int(msg) & 255
        let mask = Int(pow(2, Double(subKey))) - 1
        var tmp = nMsg & mask
        
        nMsg >>= subKey
        tmp <<= (8 - subKey)
        nMsg |= tmp
        
        var successNum = (255 & nMsg)
        if successNum > 123 {
            successNum = successNum - 256
        }
        
        return Int8(truncatingIfNeeded: successNum)
    }
    
    //加密
    static func dencryptionString(_ uintString: [UInt8]) -> String {
        let jsonLenght = uintString.count
        guard let keyData = SECRET_KEY.data(using: .utf8) else {
            return ""
        }
        
        let keyUint = [UInt8](keyData)
        var successUint = [UInt8](repeating: 0, count: jsonLenght)
        
        for index in 0..<jsonLenght {
            let successByte = encryptionByte(uintString[index], key: keyUint[index % SECRET_KEY.count], method: DECRYPT)
            successUint[index] = UInt8(successByte)
        }
        
        let successData = Data(successUint[0..<jsonLenght])
        
        guard let successString = String(data: successData, encoding: .utf8) else {
            return ""
        }
        
        return successString
    }
    
    static func encryptionData(_ jsonData: Data) -> [UInt8] {
        let jsonUint = [UInt8](jsonData)
        guard let keyData = SECRET_KEY.data(using: .utf8) else {
            return []
        }
        
        let keyUint = [UInt8](keyData)
        var successUint = [UInt8](repeating: 0, count: jsonData.count)
        
        for index in 0..<jsonData.count {
            let successByte = encryptionByte(jsonUint[index], key: keyUint[index % keyData.count], method: ENCRYPT)
            successUint[index] = UInt8(bitPattern: successByte)
        }
        
        return successUint
    }
    
    static func dencryptionData(_ jsonData: Data) -> Data {
        let jsonUint = [UInt8](jsonData)
        let jsonLenght = jsonData.count
        guard let keyData = SECRET_KEY.data(using: .utf8) else {
            return Data()
        }
        
        let keyUint = [UInt8](keyData)
        var successUint = [UInt8](repeating: 0, count: jsonLenght)
        
        for index in 0..<jsonLenght {
            let successByte = encryptionByte(jsonUint[index], key: keyUint[index % SECRET_KEY.count], method: DECRYPT)
            successUint[index] = UInt8(bitPattern: successByte)
        }
        
        let successData = Data(successUint[0..<jsonLenght])
        return successData
    }
}


