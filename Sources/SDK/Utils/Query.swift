//
//  Query.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

public class MoltinQuery {
    public enum Include: String {
        case files
        case category
    }
    
    var withIncludes: [Include]?
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
