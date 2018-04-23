//
//  Currency.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

/// Represents the meta information of a `Currency` object
public class CurrencyMeta: Codable {
    /// The timestamps of this currency
    public let timestamps: Timestamps

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// Represents a `Currency` in Moltin
open class Currency: Codable {
    /// The id of this currency
    public let id: String
    /// The type of this object
    public let type: String
    /// The currency code
    public let code: String
    /// The exchange rate between this currency and the default currency
    public let exchangeRate: Float
    /// The format of this currency
    public let format: String
    /// The decimal point character of this currency
    public let decimalPoint: String
    /// The thousands separator character of this currency
    public let thousandSeparator: String
    /// The amount of decimal places this currency has
    public let decimalPlaces: Int
    /// Whether this currency is the default currency
    public let `default`: Bool
    /// If this currency is enabled
    public let enabled: Bool
    /// The external links of this currency
    public let links: [String: String]
    /// The meta information for this currency
    public let meta: CurrencyMeta

    enum CodingKeys: String, CodingKey {
        case exchangeRate = "exchange_rate"
        case decimalPoint = "decimal_point"
        case thousandSeparator = "thousand_separator"
        case decimalPlaces = "decimal_places"

        case id
        case type
        case code
        case format
        case `default`
        case enabled
        case links
        case meta
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}
