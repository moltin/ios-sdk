//
//  CollectionRequest.swift
//  Pods
//
//  Created by Oliver Foggin on 15/02/2017.
//
//

import Foundation

public struct ProductCollectionRequest {
    public func list(withQuery query: MoltinQuery? = nil, completion: @escaping (Result<[ProductCollection]>) -> ()) {
        MoltinAPI.arrayRequest(request: Router.listCollections(query: query), completion: completion)
    }
    
    public func get(withCollectionID id: String, include: [MoltinQuery.Include]? = nil, completion: @escaping (Result<ProductCollection?>) -> ()) {
        MoltinAPI.objectRequest(request: Router.getCollection(id: id, include: include), completion: completion)
    }
}
