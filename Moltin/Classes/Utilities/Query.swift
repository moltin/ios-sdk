//
//  Query.swift
//  Pods
//
//  Created by Oliver Foggin on 15/02/2017.
//
//

import Foundation

public struct MoltinQuery {
    public enum Include: String {
        case brands
        case categories
        case collections
        case files
        case products
    }
    
    let offset: Int?
    let limit: Int?
    let sort: String?
    let filter: String?
    let include: [Include]?
    
    public init(offset: Int?, limit: Int?, sort: String?, filter: String?, include: [Include]?) {
        if let offset = offset {
            self.offset = max(0, offset)
        } else {
            self.offset = nil
        }
        
        if let limit = limit {
            self.limit = max(1, min(100, limit))
        } else {
            self.limit = nil
        }
        
        self.sort = sort
        self.filter = filter
        self.include = include
    }
}
