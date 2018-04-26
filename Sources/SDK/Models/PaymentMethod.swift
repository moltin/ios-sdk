//
//  PaymentMethod.swift
//  moltin
//
//  Created by Craig Tweedy on 03/04/2018.
//

import Foundation

/// Protocol to encapsulate all payment methods in the system, and allow developers to extend and create new payment methods when needed.
public protocol PaymentMethod {

    /// The payment data to be sent to the API
    var paymentData: [String: Any] { get }
}

/// Payment using a Stripe Token
open class StripeToken: PaymentMethod {

    /// The stripe token
    var token: String

    /// The payment data to be sent to the API
    public var paymentData: [String: Any] {
        return [
            "gateway": "stripe",
            "method": "purchase",
            "payment": self.token
        ]
    }

    /// Initialise the payment method with a stripe token
    public init(withStripeToken token: String) {
        self.token = token
    }
}

/// Payment using Stripe Card data
open class StripeCard: PaymentMethod {

    /// The first name of the person on the card
    var firstName: String
    /// The last name of the person on the card
    var lastName: String
    /// The card number
    var cardNumber: String
    /// The expiry month of the card
    var expiryMonth: String
    /// The expiry year of the card
    var expiryYear: String
    /// The CVV number of the card
    var cvvNumber: String

    /// The payment data to be sent to the API
    public var paymentData: [String: Any] {
        return [
            "gateway": "stripe",
            "method": "purchase",
            "first_name": self.firstName,
            "last_name": self.lastName,
            "number": self.cardNumber,
            "month": self.expiryMonth,
            "year": self.expiryYear,
            "verification_value": self.cvvNumber
        ]
    }

    /// Initialise the payment method with card details
    public init(
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

/// Payment using Braintree customer ID information
open class BraintreeCustomerID: PaymentMethod {

    /// The braintree customer ID
    var customerID: String
    /// Custom fields to be applied to this payment
    var customFields: [String: String]?

    /// The payment data to be sent to the API
    public var paymentData: [String: Any] {
        var data: [String: Any] = [
            "gateway": "braintree",
            "method": "purchase",
            "payment": self.customerID
        ]

        if let customFields = self.customFields {
            data["options"] = ["custom_fields": customFields]
        }

        return data
    }

    /// Initialise the payment method with a braintree customer ID and custom fields to apply to the payment
    public init(initWithCustomerID customerID: String, withCustomFields customFields: [String: String]? = nil) {
        self.customerID = customerID
        self.customFields = customFields
    }
}

/// Payment using a Braintree payment token
open class BraintreePaymentToken: PaymentMethod {

    /// The Braintree payment token
    var paymentToken: String
    /// Custom fields to be applied to this payment
    var customFields: [String: String]?

    /// The payment data to be sent to the API
    public var paymentData: [String: Any] {
        var data: [String: Any] = [
            "gateway": "braintree",
            "method": "purchase",
            "payment": self.paymentToken
        ]

        var options: [String: Any] = ["payment_method_token": true]

        if let customFields = self.customFields {
            options["custom_fields"] = customFields
        }

        data["options"] = options

        return data
    }

    /// Initialise the payment method with a braintree payment token and custom fields to apply to the payment
    public init(initWithPaymentToken paymentToken: String, withCustomFields customFields: [String: String]? = nil) {
        self.paymentToken = paymentToken
        self.customFields = customFields
    }
}

/// Payment using a Braintree payment nonce
open class BraintreePaymentNonce: PaymentMethod {

    /// The Braintree payment nonce
    var paymentNonce: String
    /// Custom fields to be applied to this payment
    var customFields: [String: String]?

    /// The payment data to be sent to the API
    public var paymentData: [String: Any] {
        var data: [String: Any] = [
            "gateway": "braintree",
            "method": "purchase",
            "payment": self.paymentNonce
            ]

        var options: [String: Any] = ["payment_method_nonce": true]

        if let customFields = self.customFields {
            options["custom_fields"] = customFields
        }

        data["options"] = options

        return data
    }

    /// Initialise the payment method with a braintree payment nonce and custom fields to apply to the payment
    public init(initWithPaymentNonce paymentNonce: String, withCustomFields customFields: [String: String]? = nil) {
        self.paymentNonce = paymentNonce
        self.customFields = customFields
    }
}

/// Payment using Ayden data
open class AdyenPayment: PaymentMethod {

    /// The first name of the person on the card
    var firstName: String
    /// The last name of the person on the card
    var lastName: String
    /// The card number
    var cardNumber: String
    /// The expiry month of the card
    var expiryMonth: String
    /// The expiry year of the card
    var expiryYear: String
    /// The CVV number of the card
    var cvvNumber: String

    /// The payment data to be sent to the API
    public var paymentData: [String: Any] {
        return [
            "gateway": "adyen",
            "method": "purchase",
            "first_name": self.firstName,
            "last_name": self.lastName,
            "number": self.cardNumber,
            "month": self.expiryMonth,
            "year": self.expiryYear,
            "verification_value": self.cvvNumber
        ]
    }

    /// Initialise the payment method with card details
    public init(
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

/// Manually authorize a payment
open class ManuallyAuthorizePayment: PaymentMethod {

    /// The payment data to be sent to the API
    public var paymentData: [String: Any] {
        return [
            "gateway": "manual",
            "method": "authorize"
        ]
    }

    /// Initialise the manual authorization payment method
    public init() {
    }
}
