//
//  KeyChainManager.swift
//  MovieInfo
//
//  Created by Михаил Костров on 15/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//


//TODO - error parser
import Foundation
import Security

class KeyChainManager {
    
    public static func getValue(forKey key: String) -> (value: String?, error: String?) {
        
        if !(key.isEmpty) {
            let query = makeQuery(key: key, forSearch: true)
            
            var item: CFTypeRef?
            let status = SecItemCopyMatching(query as CFDictionary, &item)
            
            guard status != errSecItemNotFound else { return (nil, "Запись не найдена!")}
            guard status == errSecSuccess else { return (nil, SecCopyErrorMessageString(status,nil) as String?) }
            
            let results = parseData(fromItem: item)
            
            if let result = results {
                return (result, nil)
            } else {
                return (nil, "Не удалось прочесть данные")
            }
            
        } else {
            return (nil, "Пустое значение ключа!")
        }
    }
    
    private static func parseData(fromItem item: CFTypeRef?) -> String? {
        guard let existingItem = item as? [String : Any],
            let valueData = existingItem[kSecValueData as String] as? Data,
            let value = String(data: valueData, encoding: String.Encoding.utf8)
        else {
            return nil
        }
        
        return value
    }
    
    @discardableResult
    public static func set(value: String, forKey key: String) -> (succes: Bool, error: String?) {
        
        if !(value.isEmpty) && !(key.isEmpty) {
            deleteValue(forKey: key)
            let query = makeQuery(key: key, value: value)
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else { return (false, SecCopyErrorMessageString(status,nil) as String?) }
            return (true, nil)
        } else {
            return (false, "Пустые значения ключа или значения!")
        }
    }
    
    @discardableResult
    static func deleteValue(forKey key: String) -> Bool {
        let query = makeQuery(key: key)
        let status = SecItemDelete(query as CFDictionary)
        
        return status == errSecSuccess
    }
    
    private static func makeQuery(key: String, value: String? = nil, forSearch: Bool = false) -> Dictionary<String, Any> {
        
        var dictionary = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String : "MovieInfo",
            kSecAttrAccount as String : key
        ] as [String : Any]
        
        if let value = value,
            let data = value.data(using: String.Encoding.utf8)
        {
            dictionary[kSecValueData as String] = data
        } else if forSearch {
            dictionary[kSecMatchLimit as String] = kSecMatchLimitOne
            dictionary[kSecReturnAttributes as String] = true
            dictionary[kSecReturnData as String] = true
        }
        
        return dictionary
    }
}
