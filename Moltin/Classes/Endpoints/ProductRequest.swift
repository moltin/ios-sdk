//
//  Product.swift
//  Moltin
//
//  Created by Oliver Foggin on 13/02/2017.
//  Copyright © 2017 Oliver Foggin. All rights reserved.
//

import Foundation
import Alamofire

public enum ProductInclude: String {
    case files
    case brands
    case categories
    case collections
}

public struct ProductQuery {
    let offset: Int?
    let limit: Int?
    let sort: String?
    let filter: String?
    let include: [ProductInclude]?
    
    init(offset: Int?, limit: Int?, sort: String?, filter: String?, include: [ProductInclude]?) {
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

public struct ProductRequest {
    public func list(withQuery query: ProductQuery? = nil, completion: (Result<[Product]>) -> ()) {
        MoltinAPI.jsonRequest(request: Router.listProducts(query: query)) {
            response in
            
        }
        
    }
    
    public func get(withProductID id: String, include: [ProductInclude]? = nil, completion: (Result<Product>) -> ()) {
        
    }
}
