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
    var categories: [Category] { get set }
    mutating func addCategories(fromJSON json: [JSON], requiredIDs: [String])
}

extension HasCategories {
    mutating func addCategories(fromJSON json: [JSON], requiredIDs: [String]) {
        self.categories = includedObjectsArray(fromJSONArray: json, requiredIDs: requiredIDs)
    }
}

public struct Category {
    public let id: String
    public let name: String
    public let slug: String
    public let description: String
    public let json: JSON
}

extension Category: JSONAPIDecodable {
    public init?(json: JSON, includedJSON: JSON?) {
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
    }
}
