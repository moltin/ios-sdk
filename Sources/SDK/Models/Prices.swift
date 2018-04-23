//
//  Prices.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 20/03/2018.
//

import Foundation

/// Represents a `DisplayPrice` in Moltin
public struct DisplayPrice: Codable {
    /// The amount of money
    public let amount: Int
    /// The currency of this price
    public let currency: String
    /// The formatted display price
    public let formatted: String

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// Represents display prices in Moltin with and without tax
public struct DisplayPrices: Codable {
    /// The display price including tax
    public let withTax: DisplayPrice
    /// The display price without tax
    public let withoutTax: DisplayPrice

    enum CodingKeys: String, CodingKey {
        case withTax = "with_tax"
        case withoutTax = "without_tax"
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}
