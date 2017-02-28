//
//  Collection.swift
//  Pods
//
//  Created by Oliver Foggin on 15/02/2017.
//
//

import Foundation
import Gloss

public struct ProductCollection {
    public let id: String
    public let name: String
    public let slug: String
    public let description: String
    public let json: JSON
}

extension ProductCollection: JSONAPIDecodable {
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
    }
}
