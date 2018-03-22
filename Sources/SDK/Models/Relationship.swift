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
        withIncludes includes: [String: [[String: Any]]]
    ) throws
}

public class RelationshipMany: Codable {
    public var data: [RelationshipData]?
    
    public func getIds() -> [String]? {
        return self.data?.map { $0.id }
    }
}

public class RelationshipSingle: Codable {
    public var data: RelationshipData?
    
    public func getId() -> String? {
        return self.data?.id
    }
}

public struct RelationshipData: Codable {
    public let type: String
    public let id: String
}

public class Relationships: Codable {
    public var variations: RelationshipMany = RelationshipMany()
    public var files: RelationshipMany = RelationshipMany()
    public var mainImage: RelationshipSingle = RelationshipSingle()
    public var categories: RelationshipMany = RelationshipMany()
    public var collections: RelationshipMany = RelationshipMany()
    public var brands: RelationshipMany = RelationshipMany()
    
    enum CodingKeys: String, CodingKey {
        case mainImage = "main_image"
        
        case files
        case variations
        case categories
        case collections
        case brands
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        self.mainImage = try container.decodeIfPresent(RelationshipSingle.self, forKey: .mainImage) ?? RelationshipSingle()
        
        self.files = try container.decodeIfPresent(RelationshipMany.self, forKey: .files) ?? RelationshipMany()
        self.variations = try container.decodeIfPresent(RelationshipMany.self, forKey: .variations) ?? RelationshipMany()
        self.categories = try container.decodeIfPresent(RelationshipMany.self, forKey: .categories) ?? RelationshipMany()
        self.collections = try container.decodeIfPresent(RelationshipMany.self, forKey: .collections) ?? RelationshipMany()
        self.brands = try container.decodeIfPresent(RelationshipMany.self, forKey: .brands) ?? RelationshipMany()
    }
}
