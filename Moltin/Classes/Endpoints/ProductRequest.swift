//
//  Product.swift
//  Moltin
//
//  Created by Oliver Foggin on 13/02/2017.
//  Copyright © 2017 Oliver Foggin. All rights reserved.
//

import Foundation

public struct ProductRequest {
    public func list(withQuery query: MoltinQuery? = nil, completion: @escaping (Result<[Product]>) -> ()) {
        MoltinAPI.arrayRequest(request: Router.listProducts(query: query), completion: completion)
    }
    
    public func get(withProductID id: String, include: [MoltinQuery.Include]? = nil, completion: @escaping (Result<Product?>) -> ()) {
        MoltinAPI.objectRequest(request: Router.getProduct(id: id, include: include), completion: completion)
    }
}
