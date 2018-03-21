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
    public let mainImage: ProductRelationshipSingle?
    public let categories: ProductRelationshipMany?
    public let collections: ProductRelationshipMany?
    public let brands: ProductRelationshipMany?
    
    enum CodingKeys: String, CodingKey {
        case mainImage = "main_image"
        
        case files
        case variations
        case categories
        case collections
        case brands
    }
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
    public let relationships: ProductRelationships?
    
    public var mainImage: File?
    public var files: [File]?
    
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
        let includes: [String: Any] = decoder.userInfo[.includes] as? [String: Any] ?? [:]
        
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decode(String.self, forKey: .type)
        self.name = try container.decode(String.self, forKey: .name)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.sku = try container.decode(String.self, forKey: .sku)
        self.description = try container.decode(String.self, forKey: .description)
        self.price = try container.decode([ProductPrice].self, forKey: .price)
        self.status = try container.decode(String.self, forKey: .status)
        self.meta = try container.decode(ProductMeta.self, forKey: .meta)
        self.relationships = try container.decode(ProductRelationships.self, forKey: .relationships)
        
        self.manageStock = try container.decode(Bool.self, forKey: .manageStock)
        self.commodityType = try container.decode(String.self, forKey: .commodityType)
        
        
        
        
        let mainImageId = self.relationships?.mainImage?.data?.id
        let mainImagesIncludes: [[String: Any]] = includes["main_images"] as? [[String: Any]] ?? []
        
        self.mainImage = try self.extractObject(withKey: "id", withValue: mainImageId, fromIncludes: mainImagesIncludes)
        
        let fileIds = (self.relationships?.files?.data ?? []).map { $0.id }
        let fileIncludes: [[String: Any]] = includes["files"] as? [[String: Any]] ?? []
        self.files = try self.extractArray(withKey: "id", withValues: fileIds, fromIncludes: fileIncludes)
    }
}
