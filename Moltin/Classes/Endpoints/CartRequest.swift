//
//  CartRequest.swift
//  Pods
//
//  Created by Oliver Foggin on 20/02/2017.
//
//

import Foundation

public struct CartRequest {
    public func get(withReference reference: String, completion: @escaping (Result<Cart?>) -> ()) {
        MoltinAPI.objectRequest(request: Router.getCart(reference: reference), completion: completion)
    }
}
