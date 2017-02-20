////
////  CurrencyRequest.swift
////  Pods
////
////  Created by Oliver Foggin on 14/02/2017.
////
////
//
//import Foundation
//
//public struct CurrencyRequest {
//    public func list(completion: @escaping (Result<[Currency]>) -> ()) {
//        MoltinAPI.arrayRequest(request: Router.listCurrencies, completion: completion)
//    }
//    
//    public func get(withCurrencyID id: String, completion: @escaping (Result<Currency?>) -> ()) {
//        MoltinAPI.objectRequest(request: Router.getCurrency(id: id), completion: completion)
//    }
//}
