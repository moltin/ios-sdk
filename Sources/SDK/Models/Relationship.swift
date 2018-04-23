//
//  Relationship.swift
//  moltin tvOS Example
//
//  Created by Craig Tweedy on 22/03/2018.
//

import Foundation

protocol HasRelationship {
    func decodeRelationships(
        fromRelationships relationships: Relationships?,
        withIncludes includes: IncludesContainer
    ) throws
}

/// Represents a relationship which can hold many items
public class RelationshipMany: Codable {
    /// The relationship data objects
    public var data: [RelationshipData]?

    /**
     Returns all ID's for the relationships this object holds
     
     - Author:
        Craig Tweedy
     
     - returns:
     An array of UUID's as strings, representing the ID's of the relationship objects
    */
    public func getIds() -> [String]? {
        return self.data?.map { $0.id }
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// Represents a relationship which can hold a single item
public class RelationshipSingle: Codable {
    /// The relationship data object
    public var data: RelationshipData?

    /**
     Returns the ID for the relationship this object holds
     
     - Author:
     Craig Tweedy
     
     - returns:
     An UUID as a string, representing the ID of the relationship object
     */
    public func getId() -> String? {
        return self.data?.id
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// Represents a relationship item
public struct RelationshipData: Codable {
    /// The type of this relationship
    public let type: String
    /// The id of this relationship
    public let id: String

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// Represents all possible relationships a resource can have within Moltin
open class Relationships: Codable {
    /// The `File` relationships
    public var files: RelationshipMany?
    /// The main image (`File`) relationship
    public var mainImage: RelationshipSingle?
    /// The `Category` relationships
    public var categories: RelationshipMany?
    /// The `Collection` relationships
    public var collections: RelationshipMany?
    /// The `Brand` relationships
    public var brands: RelationshipMany?
    /// The `Flow` relationship
    public var flow: RelationshipSingle?
    /// The items relationships
    public var items: RelationshipMany?
    /// The `Customer` relationship
    public var customer: RelationshipSingle?
    /// The `CartItem` relationship
    public var cartItem: RelationshipSingle?
    /// The `Product` relationships
    public var products: RelationshipMany?

    enum CodingKeys: String, CodingKey {
        case mainImage = "main_image"
        case cartItem = "cart_item"

        case files
        case categories
        case collections
        case brands
        case flow
        case items
        case customer
        case products
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}
