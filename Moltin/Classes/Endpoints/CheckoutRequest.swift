//
//  CheckoutRequest.swift
//  Pods
//
//  Created by Oliver Foggin on 22/02/2017.
//
//

import Foundation

import Alamofire

public enum PaymentMethod {
    case stripeCard(firstName: String, lastName: String, cardNumber: String, expMonth: String, expYear: String, cvv: String)
    case braintreeCustomerID(customerID: String, customFields: [String : String]?)
    case braintreeToken(paymentToken: String, customFields: [String : String]?)
    case braintreeNonce(paymentNonce: String, customFields: [String : String]?)
    
    var dictionary: [String : Any] {
        switch self {
        case .stripeCard(let firstName, let lastName, let cardNumber, let expMonth, let expYear, let cvv):
            return [
                "gateway" : "stripe",
                "method" : "purchase",
                "first_name" : firstName,
                "last_name" : lastName,
                "number" : cardNumber,
                "month" : expMonth,
                "year" : expYear,
                "verification_value" : cvv
            ]
        case .braintreeCustomerID(let customerID, let customFields):
            var d: [String : Any] = [
                "gateway" : "braintree",
                "method" : "purchase",
                "payment" : customerID
            ]
            
            if let customFields = customFields {
                d["options"] = ["custom_fields" : customFields ]
            }
            
            return d
        case .braintreeToken(let token, let customFields):
            var d: [String : Any] = [
                "gateway" : "braintree",
                "method" : "purchase",
                "payment" : token,
                ]
            
            var options: [String : Any] = ["payment_method_token" : true]
            
            if let customFields = customFields {
                options["custom_fields"] = customFields
            }
            
            d["options"] = options
            
            return d
        case .braintreeNonce(let nonce, let customFields):
            var d: [String : Any] = [
                "gateway" : "braintree",
                "method" : "purchase",
                "payment" : nonce,
                ]
            
            var options: [String : Any] = ["payment_method_nonce" : true]
            
            if let customFields = customFields {
                options["custom_fields"] = customFields
            }
            
            d["options"] = options
            
            return d
        }
    }
}

public struct CheckoutRequest {
    public func checkout(cartWithID cartID: String, forCustomer customer: Customer, withBillinagAddress billingAddress: Address, andShippingAddress shippingAddress: Address, completion: @escaping (Result<Order?>) -> ()) {
        MoltinAPI.objectRequest(request: Router.checkout(cartID: cartID,
                                                         customer: customer,
                                                         billingAddress: billingAddress,
                                                         shippingAddress: shippingAddress), completion: completion)
    }
    
    public func pay(forOrderID orderID: String, withPaymentMethod paymentMethod: PaymentMethod, completion: @escaping (DefaultDataResponse) -> ()) {
        Alamofire.request(Router.authenticate).response(completionHandler: completion)
    }
}
