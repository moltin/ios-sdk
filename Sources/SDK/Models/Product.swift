//
//  Product.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

public struct ProductPrice: Codable {
    public let amount: Int
    public let currency: String
    public let includes_tax: Bool
}

public struct ProductStock: Codable {
    public let level: Int
    public let availability: String
}

public class ProductVariationOption: Codable {
    public let id: String
    public let name: String
    public let description: String
}

public class ProductVariation: Codable {
    public let id: String
    public let options: [ProductVariationOption]
}

public class ProductRelationshipMany: Codable {
    public let data: [ProductRelationshipData]?
}

public class ProductRelationshipSingle: Codable {
    public let data: ProductRelationshipData?
}

public struct ProductRelationshipData: Codable {
    public let type: String
    public let id: String
}

public class ProductRelationships: Codable {
    public let variations: ProductRelationshipMany?
    public let files: ProductRelationshipMany?
    public let main_image: ProductRelationshipSingle?
    public let categories: ProductRelationshipMany?
    public let collections: ProductRelationshipMany?
    public let brands: ProductRelationshipMany?
}

public class ProductMeta: Codable {
    public let timestamps: Timestamps
    public let stock: ProductStock
    public let displayPrice: DisplayPrices
    public let variations: [ProductVariation]?
    public let variation_matrix: [String: String]?
    public let relationships: ProductRelationships?
}

public class Product: Codable {
    public let id: String
    public let type: String
    public let name: String
    public let slug: String
    public let sku: String
    public let manageStock: Bool
    public let description: String
    public let price: [ProductPrice]?
    public let status: String
    public let commodityType: String
    public let meta: ProductMeta
}
