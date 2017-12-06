//
//  Keychain.swift
//  keychain
//
//  Created by Lucas Paim on 22/11/2017.
//  Copyright © 2017 Lucas Paim. All rights reserved.
//

import Foundation
import KeychainSwift


class KeyChain {
    
    class func save(key: String, data: Data) {
        let keychain = KeychainSwift()
        keychain.set(data, forKey: key, withAccess: .accessibleWhenUnlocked)
    }
    
    class func load<T>(key: String, type: T.Type) -> T? {
        let keychain = KeychainSwift()
        let data = keychain.getData(key)
        return data?.to(type: type)
    }
    
    class func delete(_ key: String) {
        let keychain = KeychainSwift()
        keychain.delete(key)
        keychain.clear()
        
    }
    
}


extension Data {
    
    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.pointee }
    }
}


