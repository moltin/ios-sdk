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
}
