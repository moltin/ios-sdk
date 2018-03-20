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
    public let exchangeRate: Float
    public let format: String
    public let decimalPoint: String
    public let thousandSeparator: String
    public let decimalPlaces: Int
    public let `default`: Bool
    public let enabled: Bool
    public let links: [String: String]
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
}
