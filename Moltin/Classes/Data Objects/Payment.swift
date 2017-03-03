//
//  PaymentGateway.swift
//  Pods
//
//  Created by Oliver Foggin on 24/02/2017.
//
//

import Foundation

import Gloss

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

public struct PaymentGateway: JSONAPIDecodable {
    public let name: String
    public let slug: String
    public let isEnabled: Bool?
    let json: JSON
    
    init?(json: JSON, includedJSON: [String : JSON]?) {
        guard let name: String = "name" <~~ json,
            let slug: String = "slug" <~~ json else {
                return nil
        }
        
        self.name = name
        self.slug = slug
        self.isEnabled = "enabled" <~~ json
        self.json = json
    }
}
