//
//  CartRequest.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 23/02/2018.
//

import Foundation

public class Cart: Codable { }
public class CartItem: Codable { }
public class Address: Codable { }
public class Customer: Codable {
    let id: String
}
public class Order: Codable { }
public class CustomItem: Codable { }

public class CartRequest : MoltinRequest, Request {
    public var endpoint: String = "/carts"
    public typealias ContainedType = Cart
    
    public func get(forID id: String,
                    completionHandler: @escaping ObjectRequestHandler<Cart>) {
        
        self.get(withPath: "\(self.endpoint)/\(id)",
                completionHandler: completionHandler)
    }
    
    public func items(forCartID id: String,
                      completionHandler: @escaping CollectionRequestHandler<[CartItem]>) {
        
        self.list(withPath: "\(self.endpoint)/\(id)/items",
            completionHandler: completionHandler)
    }
    
    
    public func addProduct(_ product: Product,
                           ofQuantity quantity: Int,
                           toCart cart: String,
                           completionHandler: @escaping ObjectRequestHandler<Cart>) {
        
        let data = self.buildCartItem(withID: product.id,
                                      ofQuantity: quantity)
        
        self.post(withPath: "\(self.endpoint)/\(cart)/items",
            withData: data,
            completionHandler: completionHandler)
    }
    
    
    public func addCustomItem(_ customItem: CustomItem,
                              toCart cart: String,
                              completionHandler: @escaping ObjectRequestHandler<Cart>) {
        let data = self.buildCustomItem(withCustomItem: customItem)
        
        self.post(withPath: "\(self.endpoint)/\(cart)/items",
            withData: data,
            completionHandler: completionHandler)
    }
    
    
    public func addPromotion(_ promotion: String,
                             toCart cart: String,
                             completionHandler: @escaping ObjectRequestHandler<CartItem>) {
        
        let data = self.buildCartItem(withID: promotion,
                                      ofQuantity: 1,
                                      ofType: "promotion_item")
        
        self.post(withPath: "\(self.endpoint)/\(cart)/items",
            withData: data,
            completionHandler: completionHandler)
    }
    

    public func removeItem(_ itemID: String,
                           fromCart cart: String,
                           completionHandler: @escaping ObjectRequestHandler<Cart>) {
        
        self.delete(withPath: "\(self.endpoint)/\(cart)/items/\(itemID)",
            completionHandler: completionHandler)
    }
    

    public func updateItem(_ itemID: String,
                           withQuantity quantity: Int,
                           inCart cart: String,
                           completionHandler: @escaping ObjectRequestHandler<Cart>) {
        
        let data = self.buildCartItem(withID: itemID,
                                      ofQuantity: quantity)
        
        self.put(withPath: "\(self.endpoint)/\(cart)/items/\(itemID)",
            withData: data,
            completionHandler: completionHandler)
    }
    

    public func checkout(cart: String,
                         withCustomer customer: Customer,
                         withBillingAddress billingAddress: Address,
                         withShippingAddress shippingAddress: Address?,
                         completionHandler: @escaping ObjectRequestHandler<Order>) {
        
        let data = self.buildCartCheckoutData(withCustomer: customer,
                                              withBillingAddress: billingAddress,
                                              withShippingAddress: shippingAddress)
        
        self.post(withPath: "\(self.endpoint)/\(cart)/checkout",
            withData: data,
            completionHandler: completionHandler)
    }
    
    public func deleteCart(_ cart: String,
                           completionHandler: @escaping ObjectRequestHandler<Cart>) {
        
        self.delete(withPath: "\(self.endpoint)/\(cart)",
            completionHandler: completionHandler)
    }

    internal func buildCartItem(withID id: String, ofQuantity quantity: Int, ofType type: String = "cart_item") -> [String: Any] {
        var payload: [String: Any] = [:]
        payload["type"] = type
        
        if type == "cart_item" {
            payload["id"] = id
            payload["quantity"] = quantity
        }
        
        if type == "promotion_item" {
            payload["code"] = id
        }
        
        return payload
    }
    
    internal func buildCustomItem(withCustomItem item: CustomItem) -> [String: Any] {
        var payload: [String: Any] = [:]
        payload["type"] = "custom_item"
        return payload
    }
    
    internal func buildCartCheckoutData(withCustomer customer: Customer, withBillingAddress billingAddress: Address, withShippingAddress shippingAddress: Address?) -> [String: Any] {
        var data: [String: Any] = [:]
        let customerData: [String: Any] = ["id": customer.id]
        data["customer"] = customerData
        data["billing_address"] = billingAddress
        if let address = shippingAddress {
            data["shipping_address"] = address
        } else {
            data["shipping_address"] = billingAddress
        }
        
        return data
    }
    
}
