//
//  PaymentMethod.swift
//  moltin
//
//  Created by Craig Tweedy on 03/04/2018.
//

import Foundation

public protocol PaymentMethod {
    var paymentData: [String: Any] { get }
}

open class StripeToken: PaymentMethod {
    
    var token: String
    
    public var paymentData: [String : Any] {
        return [
            "gateway" : "stripe",
            "method" : "purchase",
            "payment" : self.token
        ]
    }
    
    init(withStripeToken token: String) {
        self.token = token
    }
}

open class StripeCard: PaymentMethod {
    
    var firstName: String
    var lastName: String
    var cardNumber: String
    var expiryMonth: String
    var expiryYear: String
    var cvvNumber: String
    
    public var paymentData: [String : Any] {
        return [
            "gateway" : "stripe",
            "method" : "purchase",
            "first_name" : self.firstName,
            "last_name" : self.lastName,
            "number" : self.cardNumber,
            "month" : self.expiryMonth,
            "year" : self.expiryYear,
            "verification_value" : self.cvvNumber
        ]
    }
    
    init(
        withFirstName firstName: String,
        withLastName lastName: String,
        withCardNumber cardNumber: String,
        withExpiryMonth expiryMonth: String,
        withExpiryYear expiryYear: String,
        withCVVNumber cvv: String
        ) {
        self.firstName = firstName
        self.lastName = lastName
        self.cardNumber = cardNumber
        self.expiryMonth = expiryMonth
        self.expiryYear = expiryYear
        self.cvvNumber = cvv
    }
}

class BraintreeCustomerID: PaymentMethod {
    
    var customerID: String
    var customFields: [String: String]?
    
    public var paymentData: [String : Any] {
        var data: [String : Any] = [
            "gateway" : "braintree",
            "method" : "purchase",
            "payment" : self.customerID
        ]
        
        if let customFields = self.customFields {
            data["options"] = ["custom_fields": customFields]
        }
        
        return data
    }
    
    init(initWithCustomerID customerID: String, withCustomFields customFields: [String: String]? = nil) {
        self.customerID = customerID
        self.customFields = customFields
    }
}

class BraintreePaymentToken: PaymentMethod {
    
    var paymentToken: String
    var customFields: [String: String]?
    
    public var paymentData: [String: Any] {
        var data: [String: Any] = [
            "gateway": "braintree",
            "method": "purchase",
            "payment": self.paymentToken,
        ]

        var options: [String: Any] = ["payment_method_token": true]

        if let customFields = self.customFields {
            options["custom_fields"] = customFields
        }

        data["options"] = options

        return data
    }
    
    init(initWithPaymentToken paymentToken: String, withCustomFields customFields: [String: String]? = nil) {
        self.paymentToken = paymentToken
        self.customFields = customFields
    }
}

class BraintreePaymentNonce: PaymentMethod {
    
    var paymentNonce: String
    var customFields: [String: String]?
    
    public var paymentData: [String: Any] {
        var data: [String: Any] = [
            "gateway": "braintree",
            "method": "purchase",
            "payment": self.paymentNonce,
            ]
        
        var options: [String: Any] = ["payment_method_nonce": true]
        
        if let customFields = self.customFields {
            options["custom_fields"] = customFields
        }
        
        data["options"] = options
        
        return data
    }
    
    init(initWithPaymentNonce paymentNonce: String, withCustomFields customFields: [String: String]? = nil) {
        self.paymentNonce = paymentNonce
        self.customFields = customFields
    }
}
