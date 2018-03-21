//
//  Query.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

public struct MoltinInclude: RawRepresentable, Equatable {
    
    public typealias RawValue = String
    
    public var rawValue: String
    
    public static let files  = MoltinInclude(rawValue: "files")
    public static let products = MoltinInclude(rawValue: "products")
    public static let collections = MoltinInclude(rawValue: "collections")
    public static let brands = MoltinInclude(rawValue: "brands")
    public static let category = MoltinInclude(rawValue: "category")
    public static let mainImage = MoltinInclude(rawValue: "main_image")
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
}

public struct MoltinFilterOperator: RawRepresentable, Equatable {
    
    public typealias RawValue = String
    
    public var rawValue: String
    
    static let eq  = MoltinFilterOperator(rawValue: "eq")
    static let like  = MoltinFilterOperator(rawValue: "like")
    static let gt  = MoltinFilterOperator(rawValue: "gt")
    static let ge  = MoltinFilterOperator(rawValue: "ge")
    static let lt  = MoltinFilterOperator(rawValue: "lt")
    static let le  = MoltinFilterOperator(rawValue: "le")
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
}

public class MoltinQuery {
    var withIncludes: [MoltinInclude]?
    var withSorting: String?
    var withLimit: String?
    var withOffset: String?
    var withFilter: [(MoltinFilterOperator, String, String)] = []
    
    func toURLQueryItems() -> [URLQueryItem] {
        var queryParams: [URLQueryItem] = []
        
        if let includes = self.withIncludes {
            queryParams.append(URLQueryItem(name: "include", value: includes.map { $0.rawValue }.joined(separator: ",")))
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
                return "\(op.rawValue)(\(key), \(value))"
            }.joined(separator: ":")
            queryParams.append(URLQueryItem(name: "filter", value: filterString))
        }
        
        return queryParams
    }
}
