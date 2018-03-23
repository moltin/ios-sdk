//
//  CartRequest.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 23/02/2018.
//

import Foundation

public class CartRequest : MoltinRequest {
    public var endpoint: String = "/carts"
    
    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[CartItem]>
    
    public func get(forID id: String,
                    completionHandler: @escaping ObjectRequestHandler<Cart>) -> MoltinRequest {
        
        return self.get(withPath: "\(self.endpoint)/\(id)",
                completionHandler: completionHandler)
    }
    
    public func items(forCartID id: String,
                      completionHandler: @escaping DefaultCollectionRequestHandler) -> MoltinRequest {
        
        return self.list(withPath: "\(self.endpoint)/\(id)/items",
            completionHandler: completionHandler)
    }
    
    
    public func addProduct(withID productID: String,
                           ofQuantity quantity: Int,
                           toCart cart: String,
                           completionHandler: @escaping ObjectRequestHandler<Cart>) -> MoltinRequest {
        
        let data = self.buildCartItem(withID: productID,
                                      ofQuantity: quantity)
        
        return self.post(withPath: "\(self.endpoint)/\(cart)/items",
            withData: data,
            completionHandler: completionHandler)
    }
    
    
    public func addCustomItem(_ customItem: CustomCartItem,
                              toCart cart: String,
                              completionHandler: @escaping ObjectRequestHandler<Cart>) -> MoltinRequest {
        let data = self.buildCustomItem(withCustomItem: customItem)
        
        return self.post(withPath: "\(self.endpoint)/\(cart)/items",
            withData: data,
            completionHandler: completionHandler)
    }
    
    
    public func addPromotion(_ promotion: String,
                             toCart cart: String,
                             completionHandler: @escaping ObjectRequestHandler<CartItem>) -> MoltinRequest {
        
        let data = self.buildCartItem(withID: promotion,
                                      ofType: .promotionItem)
        
        return self.post(withPath: "\(self.endpoint)/\(cart)/items",
            withData: data,
            completionHandler: completionHandler)
    }
    

    public func removeItem(_ itemID: String,
                           fromCart cart: String,
                           completionHandler: @escaping ObjectRequestHandler<Cart>) -> MoltinRequest {
        
        return self.delete(withPath: "\(self.endpoint)/\(cart)/items/\(itemID)",
            completionHandler: completionHandler)
    }
    

    public func updateItem(_ itemID: String,
                           withQuantity quantity: Int,
                           inCart cart: String,
                           completionHandler: @escaping ObjectRequestHandler<Cart>) -> MoltinRequest {
        
        let data = self.buildCartItem(withID: itemID,
                                      ofQuantity: quantity)
        
        return self.put(withPath: "\(self.endpoint)/\(cart)/items/\(itemID)",
            withData: data,
            completionHandler: completionHandler)
    }
    

    public func checkout(cart: String,
                         withCustomer customer: Customer,
                         withBillingAddress billingAddress: Address,
                         withShippingAddress shippingAddress: Address?,
                         completionHandler: @escaping ObjectRequestHandler<Order>) -> MoltinRequest {
        
        let data = self.buildCartCheckoutData(withCustomer: customer,
                                              withBillingAddress: billingAddress,
                                              withShippingAddress: shippingAddress)
        
        return self.post(withPath: "\(self.endpoint)/\(cart)/checkout",
            withData: data,
            completionHandler: completionHandler)
    }
    
    public func deleteCart(_ cart: String,
                           completionHandler: @escaping ObjectRequestHandler<Cart>) -> MoltinRequest {
        
        return self.delete(withPath: "\(self.endpoint)/\(cart)",
            completionHandler: completionHandler)
    }

    internal func buildCartItem(withID id: String, ofQuantity quantity: Int = 1, ofType type: CartItemType = .cartItem) -> [String: Any] {
        var payload: [String: Any] = [:]
        payload["type"] = type.rawValue
        
        if type == .cartItem {
            payload["id"] = id
            payload["quantity"] = quantity
        }
        
        if type == .promotionItem {
            payload["code"] = id
        }
        
        return payload
    }
    
    internal func buildCustomItem(withCustomItem item: CustomCartItem) -> [String: Any] {
        var payload: [String: Any] = [:]
        payload["type"] = "custom_item"
        payload["sku"] = item.sku
        return payload
    }
    
    internal func buildCartCheckoutData(withCustomer customer: Customer, withBillingAddress billingAddress: Address, withShippingAddress shippingAddress: Address?) -> [String: Any] {
        var data: [String: Any] = [:]
        let customerData: [String: Any] = ["id": customer.id ?? ""]
        data["customer"] = customerData
        var billingAddressData: [String: Any] = [:]
        billingAddressData["line_1"] = billingAddress.line1
        data["billing_address"] = billingAddressData
        if let address = shippingAddress {
            var shippingAddressData: [String: Any] = [:]
            shippingAddressData["line_1"] = address.line1
            data["shipping_address"] = shippingAddressData
        } else {
            data["shipping_address"] = data["billing_address"]
        }
        
        return data
    }
    
}
