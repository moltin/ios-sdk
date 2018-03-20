//
//  Prices.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 20/03/2018.
//

import Foundation

public struct DisplayPrice: Codable {
    public let amount: Int
    public let currency: String
    public let formatted: String
}

public struct DisplayPrices: Codable {
    public let withTax: DisplayPrice
    public let withoutTax: DisplayPrice
    
    enum CodingKeys: String, CodingKey {
        case withTax = "with_tax"
        case withoutTax = "without_tax"
    }
}
