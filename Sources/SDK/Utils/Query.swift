//
//  Query.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

public struct MoltinInclude: RawRepresentable, Equatable, Hashable, Comparable {
    
    public typealias RawValue = String
    
    public var rawValue: String
    
    static let files  = MoltinInclude(rawValue: "files")
    static let products = MoltinInclude(rawValue: "products")
    static let category = MoltinInclude(rawValue: "category")
    
    //MARK: Hashable
    
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
    //MARK: Comparable
    
    public static func <(lhs: MoltinInclude, rhs: MoltinInclude) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
}

extension MoltinInclude {
    static var main_image = MoltinInclude(rawValue: "main_image")
}

public class MoltinQuery {
    var withIncludes: [MoltinInclude]?
    var withSorting: String?
    var withLimit: String?
    var withOffset: String?
    var withFilter: [(String, String, String)] = []
    
    func toURLQueryItems() -> [URLQueryItem] {
        var queryParams: [URLQueryItem] = []
        
        if let includes = self.withIncludes {
            queryParams.append(URLQueryItem(name: "includes", value: includes.map { $0.rawValue }.joined(separator: ",")))
        }
        
        if let sort = self.withSorting {
            queryParams.append(URLQueryItem(name: "sort", value: sort))
        }
        
        if let limit = self.withLimit {
            queryParams.append(URLQueryItem(name: "limit", value: limit))
        }
        
        if let offset = self.withOffset {
            queryParams.append(URLQueryItem(name: "offset", value: offset))
        }
        
        if self.withFilter.count > 0 {
            let filterString = self.withFilter.map { (op, key, value) -> String in
                return "\(op)(\(key), \(value))"
            }.joined(separator: ":")
            queryParams.append(URLQueryItem(name: "filter", value: filterString))
        }
        
        return queryParams
    }
}
