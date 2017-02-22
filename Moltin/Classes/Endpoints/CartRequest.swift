//
//  CartRequest.swift
//  Pods
//
//  Created by Oliver Foggin on 20/02/2017.
//
//

import Foundation

public struct CartRequest {
    public func getNew(completion: @escaping (Result<Cart?>) -> ()) {
        let reference = UUID().uuidString
            
        MoltinAPI.objectRequest(request: Router.getCart(reference: reference), completion: completion)
    }
    
    public func list(itemsInCartID id: String, completion: @escaping (Result<[CartItem]>) -> ()) {
        MoltinAPI.arrayRequest(request: Router.listItems(cartID: id), completion: completion)
    }
    
    public func add(itemWithProductID productID: String, andQuantity quantity: UInt, toCartID cartID: String, completion: @escaping (Result<[CartItem]>) -> ()) {
        MoltinAPI.arrayRequest(request: Router.addItem(cartID: cartID, productID: productID, quantity: quantity), completion: completion)
    }
    
    public func add(customItem: CustomItem, toCartID cartID: String, completion: @escaping (Result<[CartItem]>) -> ()) {
        MoltinAPI.arrayRequest(request: Router.addCustomItem(customItem: customItem, cartID: cartID), completion: completion)
    }
    
    public func update(cartItemID: String, toQuantity quantity: UInt, inCartID cartID: String, completion: @escaping (Result<[CartItem]>) -> ()) {
        MoltinAPI.arrayRequest(request: Router.updateQuantity(cartID: cartID, itemID: cartItemID, quantity: quantity), completion: completion)
    }
    
    public func delete(cartItemID itemID: String, fromCartID cartID: String, completion: @escaping (Result<[CartItem]>) -> ()) {
        MoltinAPI.arrayRequest(request: Router.deleteItem(cartID: cartID, itemID: itemID), completion: completion)
    }
}
