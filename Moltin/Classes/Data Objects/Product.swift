//
//  Product.swift
//  Moltin
//
//  Created by Oliver Foggin on 13/02/2017.
//  Copyright © 2017 Oliver Foggin. All rights reserved.
//

import Foundation
import Gloss

protocol HasProducts {
    var products: [Product] { get set }
    mutating func addProducts(fromJSON json: [JSON], requiredIDs: [String])
}

extension HasProducts {
    mutating func addProducts(fromJSON json: [JSON], requiredIDs: [String]) {
        self.products = includedObjectsArray(fromJSONArray: json, requiredIDs: requiredIDs)
    }
}

public struct MTDimension {
    let width: MTMeasurement<MTUnitLength>
    let height: MTMeasurement<MTUnitLength>
    let length: MTMeasurement<MTUnitLength>
}

public struct Product: HasFiles, HasCollections, HasCategories, HasBrands {
    public let id: String
    public let name: String
    public let slug: String
    public let sku: String
    public let description: String
    public let dimensions: MTDimension?
    public let weight: MTMeasurement<MTUnitMass>?
    public var files: [File] = []
    public var collections: [Collection] = []
    public var categories: [Category] = []
    public var brands: [Brand] = []
    public let json: JSON
}

extension Product: JSONAPIDecodable {
    public init?(json: JSON, includedJSON: JSON?) {
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
        
        if let widthValue: Double = "dimensions.width.cm.value" <~~ json,
            let heightValue: Double = "dimensions.height.cm.value" <~~ json,
            let lengthValue: Double = "dimensions.length.cm.value" <~~ json {
            dimensions = MTDimension(width: MTMeasurement(value: widthValue, unit: .centimeters),
                                    height: MTMeasurement(value: heightValue, unit: .centimeters),
                                    length: MTMeasurement(value: lengthValue, unit: .centimeters))
        } else {
            dimensions = nil
        }
        
        guard let includedJSON = includedJSON else {
            return
        }
        
        if let includedFilesJSON: [JSON] = "files" <~~ includedJSON,
            let relatedFilesJSON: [JSON] = "relationships.files.data" <~~ json {
            self.addFiles(fromJSON: includedFilesJSON, requiredIDs: relatedFilesJSON.flatMap { $0["id"] as? String })
        }
        
        if let includedCollectionJSON: [JSON] = "collections" <~~ includedJSON,
            let relatedCollectionJSON: [JSON] = "relationships.collections.data" <~~ json {
            self.addCollections(fromJSON: includedCollectionJSON, requiredIDs: relatedCollectionJSON.flatMap { $0["id"] as? String })
        }
        
        if let includedCategoryJSON: [JSON] = "categories" <~~ includedJSON,
            let relatedCategoryJSON: [JSON] = "relationships.categories.data" <~~ json {
            self.addCategories(fromJSON: includedCategoryJSON, requiredIDs: relatedCategoryJSON.flatMap { $0["id"] as? String })
        }
        
        if let includedBrandJSON: [JSON] = "brands" <~~ includedJSON,
            let relatedBrandJSON: [JSON] = "relationships.brands.data" <~~ json {
            self.addBrands(fromJSON: includedBrandJSON, requiredIDs: relatedBrandJSON.flatMap { $0["id"] as? String })
        }
    }
}
