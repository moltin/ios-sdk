//
//  Product.swift
//  Moltin
//
//  Created by Oliver Foggin on 13/02/2017.
//  Copyright © 2017 Oliver Foggin. All rights reserved.
//

import Foundation
import Gloss

public struct MTDimension {
    public let width: MTMeasurement<MTUnitLength>
    public let height: MTMeasurement<MTUnitLength>
    public let length: MTMeasurement<MTUnitLength>
}

public struct Product {
    public let id: String
    public let name: String
    public let slug: String
    public let sku: String
    public let description: String
    public let dimensions: MTDimension?
    public let weight: MTMeasurement<MTUnitMass>?
    public var files: [File] = []
    public var collections: [ProductCollection] = []
    public var categories: [ProductCategory] = []
    public var brands: [Brand] = []
    public let json: JSON
    public var prices: [Price] = []
    public var displayPriceWithTax: DisplayPrice?
    public var displayPriceWithoutTax: DisplayPrice?
}

extension Product: JSONAPIDecodable {
    public init?(json: JSON, includedJSON: [String : JSON]?) {
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
        self.json = json
        
        if let weightValue: Double = "weight.g.value" <~~ json {
            weight = MTMeasurement(value: weightValue, unit: .grams)
        } else {
            weight = nil
        }
        
        if let pricesArrayJSON: [JSON] = "price" <~~ json {
            prices = [Price].from(jsonArray: pricesArrayJSON, includedJSON: nil)
        }
        
        if let displayPriceWithTaxJSON: JSON = "meta.display_price.with_tax" <~~ json {
            displayPriceWithTax = DisplayPrice(json: displayPriceWithTaxJSON, includedJSON: nil)
        } else {
            displayPriceWithTax = nil
        }
        
        if let displayPriceWithoutTaxJSON: JSON = "meta.display_price.without_tax" <~~ json {
            displayPriceWithoutTax = DisplayPrice(json: displayPriceWithoutTaxJSON, includedJSON: nil)
        } else {
            displayPriceWithoutTax = nil
        }
        
        if let widthValue: Double = "dimensions.width.cm.value" <~~ json,
            let heightValue: Double = "dimensions.height.cm.value" <~~ json,
            let lengthValue: Double = "dimensions.length.cm.value" <~~ json {
            dimensions = MTDimension(width: MTMeasurement(value: widthValue, unit: .centimeters),
                                    height: MTMeasurement(value: heightValue, unit: .centimeters),
                                    length: MTMeasurement(value: lengthValue, unit: .centimeters))
        } else {
            dimensions = nil
        }
        
        self.files = relatedObjects(fromJSON: json, withKeyPath: "relationships.files.data", includedJSON: includedJSON)
        self.collections = relatedObjects(fromJSON: json, withKeyPath: "relationships.collections.data", includedJSON: includedJSON)
        self.categories = relatedObjects(fromJSON: json, withKeyPath: "relationships.categories.data", includedJSON: includedJSON)
        self.brands = relatedObjects(fromJSON: json, withKeyPath: "relationships.brands.data", includedJSON: includedJSON)
    }
}
