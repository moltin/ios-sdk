//
//  CheckoutRequest.swift
//  Pods
//
//  Created by Oliver Foggin on 22/02/2017.
//
//

import Foundation

public struct CheckoutRequest {
    public func checkout(cartWithID cartID: String, forCustomer customer: Customer, withBillinagAddress billingAddress: Address, andShippingAddress shippingAddress: Address, completion: @escaping (Result<Order?>) -> ()) {
        MoltinAPI.objectRequest(request: Router.checkout(cartID: cartID,
                                                         customer: customer,
                                                         billingAddress: billingAddress,
                                                         shippingAddress: shippingAddress), completion: completion)
    }
}
