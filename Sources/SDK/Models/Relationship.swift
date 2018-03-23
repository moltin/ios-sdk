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
    public var files: RelationshipMany?
    public var mainImage: RelationshipSingle?
    public var categories: RelationshipMany?
    public var collections: RelationshipMany?
    public var brands: RelationshipMany?
    public var flow: RelationshipSingle?
    public var items: RelationshipMany?
    public var customer: RelationshipSingle?
    
    enum CodingKeys: String, CodingKey {
        case mainImage = "main_image"
        
        case files
        case categories
        case collections
        case brands
        case flow
        case items
        case customer
    }
}
