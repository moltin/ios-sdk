//
//  Product.swift
//  Moltin
//
//  Created by Oliver Foggin on 13/02/2017.
//  Copyright © 2017 Oliver Foggin. All rights reserved.
//

import Foundation
import Gloss

public struct Product {
    let id: String
    let name: String
    let slug: String
    let sku: String
    let description: String
    let height: Measurement<UnitLength>?
    let width: Measurement<UnitLength>?
    let length: Measurement<UnitLength>?
    let weight: Measurement<UnitMass>?
}

extension Product: Decodable {
    public init?(json: JSON) {
        guard let id: String = "id" <~~ json,
            let name: String = "name" <~~ json,
            let slug: String = "slug" <~~ json,
            let sku: String = "sku" <~~ json,
            let description: String = "description" <~~ json else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.slug = slug
        self.sku = sku
        self.description = description
        
        height = nil
        width = nil
        length = nil
        weight = nil
    }
}
