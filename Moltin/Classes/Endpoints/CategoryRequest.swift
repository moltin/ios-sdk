//
//  CategoryRequest.swift
//  Pods
//
//  Created by Oliver Foggin on 20/02/2017.
//
//

import Foundation

public struct CategoryRequest {
    public func list(withQuery query: MoltinQuery? = nil, completion: @escaping (Result<[Category]>) -> ()) {
        MoltinAPI.arrayRequest(request: Router.listCategories(query: query), completion: completion)
    }
    
    public func get(withCategoryID id: String, include: [MoltinQuery.Include]? = nil, completion: @escaping (Result<Category?>) -> ()) {
        MoltinAPI.objectRequest(request: Router.getCategory(id: id), completion: completion)
    }
}
