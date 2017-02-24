//
//  CategoryRequest.swift
//  Pods
//
//  Created by Oliver Foggin on 20/02/2017.
//
//

import Foundation

public struct ProductCategoryRequest {
    public func list(withQuery query: MoltinQuery? = nil, completion: @escaping (Result<[ProductCategory]>) -> ()) {
        MoltinAPI.arrayRequest(request: Router.listCategories(query: query), completion: completion)
    }
    
    public func get(withCategoryID id: String, include: [MoltinQuery.Include]? = nil, completion: @escaping (Result<ProductCategory?>) -> ()) {
        MoltinAPI.objectRequest(request: Router.getCategory(id: id, include: include), completion: completion)
    }
    
    public func getTree(completion: @escaping (Result<[ProductCategory]>) -> ()) {
        MoltinAPI.arrayRequest(request: Router.getCategoryTree, completion: completion)
    }
}
