//
//  Product.swift
//  Moltin
//
//  Created by Oliver Foggin on 13/02/2017.
//  Copyright © 2017 Oliver Foggin. All rights reserved.
//

import Foundation

import Gloss

public struct ProductRequest {
    public func list(withQuery query: MoltinQuery? = nil, completion: @escaping (Result<(products: [Product], meta: ProductListMeta?)>) -> ()) {
        let localCompletion: (Result<([Product], JSON?)>) -> () = {
            result in
            
            switch result {
            case .failure(let error):
                completion(Result.failure(error: error))
            case .success(let productList):
                var meta: ProductListMeta? = nil
                
                if let metaJSON = productList.1,
                    let count: Int = "counts.matching_resource_count" <~~ metaJSON {
                    meta = ProductListMeta(totalCount: count)
                }
                
                completion(Result.success(result: (productList.0, meta)))
            }
        }
        
        MoltinAPI.arrayWithMetaRequest(request: Router.listProducts(query: query), completion: localCompletion)
    }
    
    public func get(withProductID id: String, include: [MoltinQuery.Include]? = nil, completion: @escaping (Result<Product?>) -> ()) {
        MoltinAPI.objectRequest(request: Router.getProduct(id: id, include: include), completion: completion)
    }
}
