////
////  CollectionRequest.swift
////  Pods
////
////  Created by Oliver Foggin on 15/02/2017.
////
////
//
//import Foundation
//
//public struct CollectionRequest {
//    public func list(withQuery query: MoltinQuery? = nil, completion: @escaping (Result<[Collection]>) -> ()) {
//        MoltinAPI.arrayRequest(request: Router.listCollections(query: query), completion: completion)
//    }
//    
//    public func get(withCollectionID id: String, include: [MoltinQuery.Include]? = nil, completion: @escaping (Result<Collection?>) -> ()) {
//        MoltinAPI.objectRequest(request: Router.getCollection(id: id), completion: completion)
//    }
//}
