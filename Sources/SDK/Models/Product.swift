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
    public let includesTax: Bool
    
    enum CodingKeys: String, CodingKey {
        case includesTax = "includes_tax"
        
        case amount
        case currency
    }
    
    
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

public class ProductMeta: Codable {
    public let timestamps: Timestamps
    public let stock: ProductStock
    public let displayPrice: DisplayPrices
    public let variations: [ProductVariation]?
    public let variationMatrix: [String: String]?
    
    enum CodingKeys: String, CodingKey {
        case displayPrice = "display_price"
        case variationMatrix = "variation_matrix"
        
        case timestamps
        case stock
        case variations
    }
}

public class Product: Codable, HasRelationship {
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
    public let relationships: Relationships?
    
    public var mainImage: File?
    public var files: [File]?
    public var categories: [Category]?
    public var brands: [Brand]?
    public var collections: [Collection]?
    
    enum CodingKeys: String, CodingKey {
        case manageStock = "manage_stock"
        case commodityType = "commodity_type"
        
        case id
        case type
        case name
        case slug
        case sku
        case description
        case price
        case status
        case meta
        case relationships
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let includes: IncludesContainer = decoder.userInfo[.includes] as? IncludesContainer ?? [:]
        
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decode(String.self, forKey: .type)
        self.name = try container.decode(String.self, forKey: .name)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.sku = try container.decode(String.self, forKey: .sku)
        self.description = try container.decode(String.self, forKey: .description)
        self.price = try container.decode([ProductPrice].self, forKey: .price)
        self.status = try container.decode(String.self, forKey: .status)
        self.meta = try container.decode(ProductMeta.self, forKey: .meta)
        self.relationships = try container.decode(Relationships.self, forKey: .relationships)
        
        self.manageStock = try container.decode(Bool.self, forKey: .manageStock)
        self.commodityType = try container.decode(String.self, forKey: .commodityType)
        
        try self.decodeRelationships(fromRelationships: self.relationships, withIncludes: includes)
        
    }
}

extension Product {
    
    func decodeRelationships(
        fromRelationships relationships: Relationships?,
        withIncludes includes: IncludesContainer
    ) throws {

        self.mainImage = try self.decodeSingle(
            fromRelationships: relationships?[keyPath: \Relationships.mainImage],
            withIncludes: includes["main_images"])

        self.files = try self.decodeMany(
            fromRelationships: relationships?[keyPath: \Relationships.files],
            withIncludes: includes["files"])
        
        self.categories = try self.decodeMany(
            fromRelationships: relationships?[keyPath: \Relationships.categories],
            withIncludes: includes["categories"])
        
        self.brands = try self.decodeMany(
            fromRelationships: relationships?[keyPath: \Relationships.brands],
            withIncludes: includes["brands"])
        
        self.collections = try self.decodeMany(
            fromRelationships: relationships?[keyPath: \Relationships.collections],
            withIncludes: includes["collections"])

    }
}
