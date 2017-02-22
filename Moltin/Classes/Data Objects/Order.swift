//
//  Order.swift
//  Pods
//
//  Created by Oliver Foggin on 22/02/2017.
//
//

import Foundation

import Gloss

public struct Order {
    public enum Status: String {
        case incomplete
        case cacelled
        case complete
    }
    
    public enum Payment: String {
        case unpaid
        case authorized
        case notApplicable = "not_applicable"
        case paid
    }
    
    public enum Shipping: String {
        case notShipped = "not_shipped"
        case partial
        case shipped
    }
    
    public let id: String
    public let status: Order.Status
    public let payment: Order.Payment
    public let shipping: Order.Shipping
    public let customer: Customer
    public let shippingAddress: Address
    public let billingAddress: Address
}

extension Order: JSONAPIDecodable {
    init?(json: JSON, includedJSON: JSON?) {
        guard let id: String = "id" <~~ json,
            let statusString: String = "status" <~~ json,
            let status = Status(rawValue: statusString),
            let paymentString: String = "payment" <~~ json,
            let payment = Payment(rawValue: paymentString),
            let shippingString: String = "shipping_address" <~~ json,
            let shipping = Shipping(rawValue: shippingString),
            let customerJSON: JSON = "customer" <~~ json,
            let customer = Customer(json: customerJSON, includedJSON: nil),
            let shippingJSON: JSON = "shipping_address" <~~ json,
            let shippingAddress = Address(json: shippingJSON, includedJSON: nil),
            let billingJSON: JSON = "billing_address" <~~ json,
            let billingAddress = Address(json: billingJSON, includedJSON: nil) else {
                return nil
        }
        
        self.id = id
        self.status = status
        self.payment = payment
        self.shipping = shipping
        self.customer = customer
        self.shippingAddress = shippingAddress
        self.billingAddress = billingAddress
    }
}
