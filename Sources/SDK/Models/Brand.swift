//
//  Brand.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

/// Represents a `Brand` in Moltin
open class Brand: Codable, HasRelationship {
    /// The id of this brand
    public let id: String
    /// The type of this object
    public let type: String
    /// The name of this brand
    public let name: String
    /// The slug of this brand
    public let slug: String
    /// The description of this brand
    public let description: String
    /// draft / live
    public let status: String
    /// The relationships this brand has
    public let relationships: Relationships?

    /// The brands this brand is associated with
    public var brands: [Brand]?
    /// The products this brand is associated with
    public var products: [Product]?

    /// The children of this brand
    public var children: [Brand]?

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let includes: IncludesContainer = decoder.userInfo[.includes] as? IncludesContainer ?? [:]

        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decode(String.self, forKey: .type)
        self.name = try container.decode(String.self, forKey: .name)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.description = try container.decode(String.self, forKey: .description)
        self.status = try container.decode(String.self, forKey: .status)
        self.relationships = try container.decodeIfPresent(Relationships.self, forKey: .relationships)
        self.children = try container.decodeIfPresent([Brand].self, forKey: .children)

        try self.decodeRelationships(fromRelationships: self.relationships, withIncludes: includes)
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

extension Brand {
    func decodeRelationships(
        fromRelationships relationships: Relationships?,
        withIncludes includes: IncludesContainer) throws {

        self.brands = try self.decodeMany(fromRelationships: self.relationships?[keyPath: \Relationships.brands],
                                      withIncludes: includes["brands"])

        self.products = try self.decodeMany(fromRelationships: self.relationships?[keyPath: \Relationships.products],
                                      withIncludes: includes["products"])
    }
}
