//
//  CartRequest.swift
//  Pods
//
//  Created by Oliver Foggin on 20/02/2017.
//
//

import Foundation

import Gloss

public typealias CartItemList = (items: [CartItem], meta: CartMeta?)

public struct CartRequest {
    public func getNew(completion: @escaping (Result<Cart?>) -> ()) {
        let reference = UUID().uuidString
            
        MoltinAPI.objectRequest(request: Router.getCart(reference: reference), completion: completion)
    }
    
    func processMetaData(result: Result<([CartItem], JSON?)>, completion: @escaping (Result<CartItemList>) -> ()) {
        switch result {
        case .failure(let error):
            completion(Result.failure(error: error))
        case .success(let list):
            var cartMeta: CartMeta? = nil
            
            if let metaJSON = list.1 {
                cartMeta = CartMeta(json: metaJSON, includedJSON: nil)
            }
            
            completion(Result.success(result: (list.0, cartMeta)))
        }
    }
    
    public func list(itemsInCartID id: String, completion: @escaping (Result<CartItemList>) -> ()) {
        MoltinAPI.arrayWithMetaRequest(request: Router.listItems(cartID: id)) { result in
            self.processMetaData(result: result, completion: completion)
        }
    }
    
    public func add(itemWithProductID productID: String, andQuantity quantity: UInt, toCartID cartID: String, completion: @escaping (Result<CartItemList>) -> ()) {
        MoltinAPI.arrayWithMetaRequest(request: Router.addItem(cartID: cartID, productID: productID, quantity: quantity)) { result in
            self.processMetaData(result: result, completion: completion)
        }
    }
    
    public func add(customItem: CustomItem, toCartID cartID: String, completion: @escaping (Result<CartItemList>) -> ()) {
        MoltinAPI.arrayWithMetaRequest(request: Router.addCustomItem(customItem: customItem, cartID: cartID)) { result in
            self.processMetaData(result: result, completion: completion)
        }
    }
    
    public func update(cartItemID: String, toQuantity quantity: UInt, inCartID cartID: String, completion: @escaping (Result<CartItemList>) -> ()) {
        MoltinAPI.arrayWithMetaRequest(request: Router.updateQuantity(cartID: cartID, itemID: cartItemID, quantity: quantity)) { result in
            self.processMetaData(result: result, completion: completion)
        }
    }
    
    public func delete(cartItemID itemID: String, fromCartID cartID: String, completion: @escaping (Result<CartItemList>) -> ()) {
        MoltinAPI.arrayWithMetaRequest(request: Router.deleteItem(cartID: cartID, itemID: itemID)) { result in
            self.processMetaData(result: result, completion: completion)
        }
    }
}
