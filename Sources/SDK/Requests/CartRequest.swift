//
//  CartRequest.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 23/02/2018.
//

import Foundation

/// An entry point to make API calls relating to `Cart`
public class CartRequest: MoltinRequest {
    /**
     The API endpoint for this resource.
     */
    public var endpoint: String = "/carts"

    /**
     A typealias which allows automatic casting of a collection to `[CartItem]`.
     */
    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[CartItem]>

    /**
     Return instance of type `Cart` by `id`
     
    - Author:
        Craig Tweedy
     
     - parameters:
        - forID: The ID of the object
        - completionHandler: The handler to be called on success or failure
     
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func get(forID id: String,
                                       completionHandler: @escaping ObjectRequestHandler<Cart>) -> MoltinRequest {

        return self.get(withPath: "\(self.endpoint)/\(id)",
                completionHandler: completionHandler)
    }

    /**
     Returns an array of `CartItem` for a requested `Cart`
     
     - Author:
        Craig Tweedy
     
     - parameters:
        - forCartID: The ID of the object
        - completionHandler: The handler to be called on success or failure
     
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func items(forCartID id: String,
                                         completionHandler: @escaping DefaultCollectionRequestHandler) -> MoltinRequest {

        return self.list(withPath: "\(self.endpoint)/\(id)/items",
            completionHandler: completionHandler)
    }

    /**
     Adds an amount of products with `productID` to a specified `Cart` with `toCart`
     
     - Author:
        Craig Tweedy
     
     - parameters:
        - withID: The ID of the product
        - ofQuantity: The amount of this product to add to the cart
        - toCart: The cart ID to add this product to
        - completionHandler: The handler to be called on success or failure
     
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func addProduct(withID productID: String,
                                              ofQuantity quantity: Int,
                                              toCart cart: String,
                                              completionHandler: @escaping ObjectRequestHandler<[CartItem]>) -> MoltinRequest {

        let data = self.buildCartItem(withID: productID,
                                      ofQuantity: quantity)

        return self.post(withPath: "\(self.endpoint)/\(cart)/items",
            withData: data,
            completionHandler: completionHandler)
    }

    /**
     Adds a custom cart item to a cart
     
     - Author:
        Craig Tweedy
     
     - parameters:
        - customItem: The custom cart item to add to this cart
        - toCart: The cart ID to add this item to
        - completionHandler: The handler to be called on success or failure
     
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func addCustomItem(_ customItem: CustomCartItem,
                                                 toCart cart: String,
                                                 completionHandler: @escaping ObjectRequestHandler<Cart>) -> MoltinRequest {
        let data = self.buildCustomItem(withCustomItem: customItem)

        return self.post(withPath: "\(self.endpoint)/\(cart)/items",
            withData: data,
            completionHandler: completionHandler)
    }

    /**
     Adds a promotion to a cart
     
     - Author:
        Craig Tweedy
     
     - parameters:
        - promotion: The promotion code
        - toCart: The cart ID to add this promo to
        - completionHandler: The handler to be called on success or failure
     
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func addPromotion(_ promotion: String,
                                                toCart cart: String,
                                                completionHandler: @escaping ObjectRequestHandler<Cart>) -> MoltinRequest {

        let data = self.buildCartItem(withID: promotion,
                                      ofType: .promotionItem)

        return self.post(withPath: "\(self.endpoint)/\(cart)/items",
            withData: data,
            completionHandler: completionHandler)
    }

    /**
     Removes an item from the cart
     
     - Author:
        Craig Tweedy
     
     - parameters:
        - itemID: The cart item ID to remove
        - fromCart: The cart ID to remove this item from
        - completionHandler: The handler to be called on success or failure
     
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func removeItem(_ itemID: String,
                                              fromCart cart: String,
                                              completionHandler: @escaping ObjectRequestHandler<Cart>) -> MoltinRequest {

        return self.delete(withPath: "\(self.endpoint)/\(cart)/items/\(itemID)",
            completionHandler: completionHandler)
    }

    /**
     Updates an item in the cart
     
     - Author:
        Craig Tweedy
     
     - parameters:
        - itemID: The item ID to update
        - withQuantity: The amount of this item ID to update too.
        - inCart: The cart ID to update this item in
        - completionHandler: The handler to be called on success or failure
     
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func updateItem(_ itemID: String,
                                              withQuantity quantity: Int,
                                              inCart cart: String,
                                              completionHandler: @escaping ObjectRequestHandler<Cart>) -> MoltinRequest {

        let data = self.buildCartItem(withID: itemID,
                                      ofQuantity: quantity)

        return self.put(withPath: "\(self.endpoint)/\(cart)/items/\(itemID)",
            withData: data,
            completionHandler: completionHandler)
    }

    /**
        Begins the checkout process for this cart
     
     - Author:
        Craig Tweedy
     
     - parameters:
        - cart: The cart ID to checkout
        - withCustomer: A customer to check this cart out with
        - withBillingAddress: The billing address for this checkout process
        - withShippingAddress: An optional shipping address for this checkout process
        - completionHandler: The handler to be called on success or failure
     
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func checkout(cart: String,
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

    /**
     Pay for an order
     
     - Author:
     Craig Tweedy
     
     - parameters:
     - forOrderID: The order to pay for
     - withPaymentMethod: The payment method to pay with
     - completionHandler: The handler to be called on success or failure
     
     - returns:
     A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func pay(forOrderID order: String,
                                       withPaymentMethod paymentMethod: PaymentMethod,
                                       completionHandler: @escaping ObjectRequestHandler<OrderSuccess>) -> MoltinRequest {

        return self.post(withPath: "/orders/\(order)/payments",
            withData: paymentMethod.paymentData,
            completionHandler: completionHandler)
    }

    /**
     Delete a cart
     
     - Author:
        Craig Tweedy
     
     - parameters:
        - cart: The cart ID to delete
        - completionHandler: The handler to be called on success or failure
     
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func deleteCart(_ cart: String,
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

    internal func buildCartCheckoutData(withCustomer customer: Customer,
                                        withBillingAddress billingAddress: Address,
                                        withShippingAddress shippingAddress: Address?) -> [String: Any] {
        var data: [String: Any] = [:]

        data["customer"] = customer.toDictionary()

        data["billing_address"] = billingAddress.toDictionary()

        if let address = shippingAddress {
            data["shipping_address"] = address.toDictionary()
        } else {
            data["shipping_address"] = data["billing_address"]
        }

        return data
    }

}
