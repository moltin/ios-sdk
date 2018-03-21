//
//  CodableExtract.swift
//  moltin
//
//  Created by Craig Tweedy on 21/03/2018.
//

import Foundation

extension Decodable {
    
    public func extractObject<T: Codable>(withKey key: String, withValue value: String?, fromIncludes includes: [[String: Any]]) throws -> T? {
        
        let foundItem = includes.first { (obj) -> Bool in
            return obj[key] as? String == value
        }
        guard let item = foundItem else {
            return nil
        }
        let itemData = try JSONSerialization.data(withJSONObject: item, options: [])
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let dateString = try decoder.singleValueContainer().decode(String.self)
            if let date = DateFormatter.iso8601Full.date(from: dateString) {
                return date
            }
            
            if let date = DateFormatter.iso8601NoMilli.date(from: dateString) {
                return date
            }
            
            throw MoltinError.couldNotParseDate
        })
        
        return try decoder.decode(T.self, from: itemData)
    }
    
    public func extractArray<T: Codable>(withKey key: String, withValues values: [String], fromIncludes includes: [[String: Any]]) throws -> [T]? {
        
        let items = includes.filter { (obj) -> Bool in
            return values.contains(obj[key] as? String ?? "")
        }
        let itemData = try JSONSerialization.data(withJSONObject: items, options: [])
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let dateString = try decoder.singleValueContainer().decode(String.self)
            if let date = DateFormatter.iso8601Full.date(from: dateString) {
                return date
            }
            
            if let date = DateFormatter.iso8601NoMilli.date(from: dateString) {
                return date
            }
            
            throw MoltinError.couldNotParseDate
        })
        
        return try decoder.decode([T].self, from: itemData)
    }
    
}
