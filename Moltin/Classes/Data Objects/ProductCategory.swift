//
//  Category.swift
//  Pods
//
//  Created by Oliver Foggin on 20/02/2017.
//
//

import Foundation
import Gloss

public struct ProductCategory {
    public let id: String
    public let name: String
    public let slug: String
    public let description: String
    public var children: [ProductCategory] = []
    public var products: [Product] = []
    public let json: JSON
}

extension ProductCategory: JSONAPIDecodable {
    public init?(json: JSON, includedJSON: [String : JSON]?) {
        guard let id: String = "id" <~~ json,
            let name: String = "name" <~~ json,
            let slug: String = "slug" <~~ json,
            let description: String = "description" <~~ json else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.slug = slug
        self.description = description
        self.json = json
        
        if let childrenJSON: [JSON] = "children" <~~ json,
            0 < childrenJSON.count {
            self.children = childrenJSON.flatMap {
                return ProductCategory(json: $0, includedJSON: nil)
            }
        }
        
        self.products = relatedObjects(fromJSON: json, withKeyPath: "relationships.products.data", includedJSON: includedJSON)
    }
}
