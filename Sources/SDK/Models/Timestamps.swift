//
//  Timestamps.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 20/03/2018.
//

import Foundation

/// Represents common timestamps returned from Moltin
open class Timestamps: Codable {
    /// When the resource was created
    public let createdAt: Date
    /// When the resource was updated
    public let updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}
