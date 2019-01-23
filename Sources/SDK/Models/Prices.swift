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
}

/// Represents display prices in Moltin with and without tax, and the tax value
public struct DisplayPrices: Codable {
    /// The display price including tax
    public let withTax: DisplayPrice
    /// The display price without tax
    public let withoutTax: DisplayPrice
    /// The display price for tax
    public let tax: DisplayPrice?

    enum CodingKeys: String, CodingKey {
        case withTax = "with_tax"
        case withoutTax = "without_tax"
        case tax
    }
}
