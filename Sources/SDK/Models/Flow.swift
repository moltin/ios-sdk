//
//  Flow.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

/// Represents a `Entry` in Moltin
open class Entry: Codable {
    /// The id of this entry
    public let id: String
    /// The type of this object
    public let type: String

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// Represents the meta information for a `Field`
public struct FieldMeta: Codable {
    /// The timestamps for this `Field`
    public let timestamps: Timestamps

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// Represents a `Field` in Moltin
open class Field: Codable {
    /// The id of this field
    public let id: String
    /// The type of this object
    public let type: String
    /// The type of this field - string / integer / boolean / float / date / relationship
    public let fieldType: String
    /// The slug for this field
    public let slug: String
    /// The name for this field
    public let name: String
    /// The description of this field
    public let description: String
    /// Whether this field is required or not
    public let required: Bool
    /// Whether this field is unique or not
    public let unique: Bool
//    public let `default`: Any
    /// Whether this field is enabled or not
    public let enabled: Bool
//    public let validationRules: [String: Any]
    /// The relationships for this Field
    public let relationships: Relationships?
    /// The meta information for this Field
    public let meta: FieldMeta?

    enum CodingKeys: String, CodingKey {
        case fieldType = "field_type"

        case id
        case type
        case slug
        case name
        case description
        case required
        case unique
        case enabled
        case relationships
        case meta
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// Represents a `Flow` in Moltin
open class Flow: Codable {
    /// The id of this flow
    public let id: String
    /// The type of this object
    public let type: String
    /// The name of this flow
    public let name: String
    /// The slug of this flow
    public let slug: String
    /// The description of this flow
    public let description: String
    /// Whether this flow is enabled or not
    public let enabled: Bool

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}
