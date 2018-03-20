//
//  Currency.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

public class CurrencyMeta: Codable {
    public let timestamps: Timestamps
}

public class Currency: Codable {
    public let id: String
    public let type: String
    public let code: String
    public let exchange_rate: Float
    public let format: String
    public let decimal_point: String
    public let thousand_separator: String
    public let decimal_places: Int
    public let `default`: Bool
    public let enabled: Bool
    public let links: [String: String]
    public let meta: CurrencyMeta
}
