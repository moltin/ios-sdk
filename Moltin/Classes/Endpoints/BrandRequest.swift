//
//  BrandRequest.swift
//  Pods
//
//  Created by Oliver Foggin on 20/02/2017.
//
//

import Foundation

public struct BrandRequest {
    public func list(withQuery query: MoltinQuery? = nil, completion: @escaping (Result<[Brand]>) -> ()) {
        MoltinAPI.arrayRequest(request: Router.listBrands(query: query), completion: completion)
    }
    
    public func get(withBrandID id: String, include: [MoltinQuery.Include]? = nil, completion: @escaping (Result<Brand?>) -> ()) {
        MoltinAPI.objectRequest(request: Router.getBrand(id: id), completion: completion)
    }
}
