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
}
