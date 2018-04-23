//
//  Collection.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

/// Represents a `Collection` in Moltin
open class Collection: Codable, HasRelationship {
    /// The id of this collection
    public let id: String
    /// The type of this object
    public let type: String
    /// The name of this collection
    public let name: String
    /// The slug of this collection
    public let slug: String
    /// The description of this collection
    public let description: String
    /// live / draft
    public let status: String
    /// The relationships this collection has
    public let relationships: Relationships?

    /// The collections associated with this collection
    public var collections: [Collection]?
    /// The products associated with this collection
    public var products: [Product]?

    /// The children of this collection
    public var children: [Collection]?

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
        self.children = try container.decodeIfPresent([Collection].self, forKey: .children)

        try self.decodeRelationships(fromRelationships: self.relationships, withIncludes: includes)
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

extension Collection {
    func decodeRelationships(
        fromRelationships relationships: Relationships?,
        withIncludes includes: IncludesContainer) throws {

        self.collections = try self.decodeMany(fromRelationships: self.relationships?[keyPath: \Relationships.collections],
                                              withIncludes: includes["collections"])

        self.products = try self.decodeMany(fromRelationships: self.relationships?[keyPath: \Relationships.products],
                                            withIncludes: includes["products"])
    }
}
