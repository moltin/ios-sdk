//
//  Order.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

/// Represents the meta information for an `Order`
public class OrderMeta: Codable {
    /// The display price information for an order
    public let displayPrice: DisplayPrices
    /// The timestamps for an order
    public let timestamps: Timestamps

    enum CodingKeys: String, CodingKey {
        case displayPrice = "display_price"
        case timestamps
    }
}

/// Represents the relationships for an `Order`
public class OrderRelationships: Codable {
    /// The items in this order
    public let items: [String: [[String: String]]]?
    /// The customer information in this order
    public let customer: [String: [String: String]]?
}

/// Represents a `Order` in Moltin
open class Order: Codable {
    /// This id of this order
    public let id: String
    /// The type of this object
    public let type: String
    /// incomplete / cancelled / complete
    public let status: String
    /// unpaid / authorized / paid / refunded
    public let payment: String
    /// fulfilled / unfulfilled
    public let shipping: String
    /// The customer for this order
    public let customer: Customer
    /// The shipping address for this order
    public let shippingAddress: Address
    /// The billing address for this order
    public let billingAddress: Address
    /// The external links for this order
    public let links: [String: String]
    /// The meta information for this order
    public let meta: OrderMeta
    /// The relationships for this order
    public let relationships: OrderRelationships?

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case status
        case payment
        case shipping
        case customer
        case shippingAddress = "shipping_address"
        case billingAddress = "billing_address"
        case links
        case meta
        case relationships
    }
}

/// Denotes a successful order returned from the payment gateway
open class OrderSuccess: Codable {

}
