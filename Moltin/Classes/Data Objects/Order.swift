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
        case cancelled
        case complete
    }
    
    public enum Payment: String {
        case unpaid
        case authorized
        case notApplicable = "not_applicable"
        case paid
    }
    
    public enum Shipping: String {
        case unfulfilled = "unfulfilled"
        case fulfilled
    }
    
    public let id: String
    public let status: Order.Status
    public let payment: Order.Payment
    public let shipping: Order.Shipping
    public let customer: Customer
    public let shippingAddress: Address
    public let billingAddress: Address
    public let totalProductCount: Int?
    public let uniqueProductCount: Int?
    public var displayPriceWithTax: DisplayPrice?
    public var displayPriceWithoutTax: DisplayPrice?
    public let gateways: [PaymentGateway]
    public let json: JSON
}

extension Order: JSONAPIDecodable {
    init?(json: JSON, includedJSON: [String : JSON]?) {
        guard let id: String = "id" <~~ json,
            let statusString: String = "status" <~~ json,
            let status = Status(rawValue: statusString),
            let paymentString: String = "payment" <~~ json,
            let payment = Payment(rawValue: paymentString),
            let shippingString: String = "shipping" <~~ json,
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
        
        self.totalProductCount = "meta.counts.products.total" <~~ json
        self.uniqueProductCount = "meta.counts.products.unique" <~~ json
        
        if let valueJSON: JSON = "meta.display_price.with_tax" <~~ json {
            self.displayPriceWithTax = DisplayPrice(json: valueJSON, includedJSON: nil)
        } else {
            self.displayPriceWithTax = nil
        }
        
        if let valueJSON: JSON = "meta.display_price.without_tax" <~~ json {
            self.displayPriceWithoutTax = DisplayPrice(json: valueJSON, includedJSON: nil)
        } else {
            self.displayPriceWithoutTax = nil
        }
        
        if let gatewaysJSON: [JSON] = "meta.gateways" <~~ json {
            self.gateways = [PaymentGateway].from(jsonArray: gatewaysJSON, includedJSON: nil)
        } else {
            self.gateways = []
        }
        
        self.json = json
    }
}
