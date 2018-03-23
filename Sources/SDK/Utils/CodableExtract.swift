//
//  CodableExtract.swift
//  moltin
//
//  Created by Craig Tweedy on 21/03/2018.
//

import Foundation

public typealias IncludesContainer = [String: [[String: Any]]]
public typealias IncludesData = [[String: Any]]

extension Decodable {
    
    public func decodeSingle<T: Codable>(
        fromRelationships relationships: RelationshipSingle?,
        withIncludes includes: IncludesData? = []) throws -> T? {
        let data: T? = try self.extractObject(withKey: "id",
                                           withValue: relationships?.getId(),
                                           fromIncludes: includes)
        
        return data
    }
    
    public func decodeMany<T: Codable>(
        fromRelationships relationships: RelationshipMany?,
        withIncludes includes: IncludesData? = []) throws -> [T]? {
        let data: [T]? = try self.extractArray(
            withKey: "id",
            withValues: relationships?.getIds(),
            fromIncludes: includes)
        
        return data
    }
    
    private func extractObject<T: Codable>(withKey key: String, withValue value: String?, fromIncludes includes: IncludesData? = []) throws -> T? {
        
        let foundItem = includes?.first { (obj) -> Bool in
            return obj[key] as? String == value
        }
        guard let item = foundItem else {
            return nil
        }
        let itemData = try JSONSerialization.data(withJSONObject: item, options: [])
        
        let decoder = JSONDecoder.dateFormattingDecoder()
        return try decoder.decode(T.self, from: itemData)
    }
    
    private func extractArray<T: Codable>(withKey key: String, withValues values: [String]? = [], fromIncludes includes: IncludesData? = []) throws -> [T]? {
        
        let items = includes?.filter { (obj) -> Bool in
            return values?.contains(obj[key] as? String ?? "") ?? false
        } ?? []
        let itemData = try JSONSerialization.data(withJSONObject: items, options: [])
        
        let decoder = JSONDecoder.dateFormattingDecoder()
        return try decoder.decode([T].self, from: itemData)
    }
    
}

extension JSONDecoder {
    static public func dateFormattingDecoder() -> JSONDecoder {
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
        return decoder
    }
}
