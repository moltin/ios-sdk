//
//  Transaction.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 01/02/2019.
//

import Foundation

/// Represents a `Transaction` in Moltin
open class Transaction: Codable {
    /// This id of this order
    public let id: String
    /// The type of this object
    public let type: String
    /// The payment gateway reference
    public let reference: String
    /// The name of the payment gateway used
    public let gateway: String
    /// The amount for this transaction
    public let amount: Int
    /// The transaction currency
    public let currency: String
    /// The type of transaction (purchase, capture, authorize or refund)
    public let transactionType: String
    /// The status provided by the gateway for this transaction (complete or failed)
    public let status: String

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case reference
        case gateway
        case amount
        case currency
        case transactionType = "transaction-type"
        case status
    }
}
