//
//  Order.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

public class OrderMeta: Codable {
    public let displayPrice: DisplayPrices
    public let timestamps: Timestamps
    
    enum CodingKeys: String, CodingKey {
        case displayPrice = "display_price"
        case timestamps
    }
}

public class OrderRelationships: Codable {
    public let items: [String: [[String: String]]]
    public let customer: [String: [String: String]]
}

public class Order: Codable {
    public let id: String
    public let type: String
    public let status: String
    public let payment: String
    public let shipping: String
    public let customer: Customer
    public let shippingAddress: Address
    public let billingAddress: Address
    public let links: [String: String]
    public let meta: OrderMeta
    public let relationships: OrderRelationships
    
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
