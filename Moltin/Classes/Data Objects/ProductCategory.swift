//
//  Category.swift
//  Pods
//
//  Created by Oliver Foggin on 20/02/2017.
//
//

import Foundation
import Gloss

protocol HasCategories {
    var categories: [ProductCategory] { get set }
    mutating func addCategories(fromJSON json: [String : JSON], requiredIDs: [String])
}

extension HasCategories {
    mutating func addCategories(fromJSON json: [String : JSON], requiredIDs: [String]) {
        self.categories = includedObjectsArray(fromIncludedJSON: json, requiredIDs: requiredIDs)
    }
}

public struct ProductCategory: HasProducts {
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
        
        
        
        if let includedJSON = includedJSON,
            let relatedProductsJSON: [JSON] = "relationships.products.data" <~~ json {
            self.addProducts(fromIncludedJSON: includedJSON, requiredIDs: relatedProductsJSON.flatMap { $0["id"] as? String })
        }
    }
}
