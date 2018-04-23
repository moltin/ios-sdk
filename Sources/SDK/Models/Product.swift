//
//  Product.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

/// Represents a price on a `Product`
public struct ProductPrice: Codable {
    /// The amount this product can sell for
    public let amount: Int
    /// The currency this price is in
    public let currency: String
    /// Whether this price includes tax
    public let includesTax: Bool

    enum CodingKeys: String, CodingKey {
        case includesTax = "includes_tax"

        case amount
        case currency
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// Represents stock levels on a `Product`
public struct ProductStock: Codable {
    /// The level of stock a product has
    public let level: Int
    /// in-stock / out-stock
    public let availability: String

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// Represents variation options on a `Product`
public class ProductVariationOption: Codable {
    /// The id of this option
    public let id: String
    /// The name of this option
    public let name: String
    /// The description of this option
    public let description: String

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// Represents variations on a `Product`
public class ProductVariation: Codable {
    /// The id of this variation
    public let id: String
    /// The options this variation has
    public let options: [ProductVariationOption]

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// Represents the meta properties of a `Product`
public class ProductMeta: Codable {
    /// The timestamps of this product
    public let timestamps: Timestamps
    /// The stock information of this product
    public let stock: ProductStock
    /// The display price information of this product
    public let displayPrice: DisplayPrices?
    /// The variations this product has
    public let variations: [ProductVariation]?
    /// The variation matrix of this product
    public let variationMatrix: [[String: String]]?

    enum CodingKeys: String, CodingKey {
        case displayPrice = "display_price"
        case variationMatrix = "variation_matrix"

        case timestamps
        case stock
        case variations
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// Represents a `Product` in moltin
open class Product: Codable, HasRelationship {
    /// The id of this product
    public let id: String
    /// The type of this object
    public let type: String
    /// The name of this product
    public let name: String
    /// The slug of this product
    public let slug: String
    /// The SKU of this product
    public let sku: String
    /// Whether or not moltin manages the stock of this product
    public let manageStock: Bool
    /// The description of this product
    public let description: String
    /// The price information for this product
    public let price: [ProductPrice]?
    /// draft / live
    public let status: String
    /// Physical / Digital
    public let commodityType: String
    /// The meta information for this product
    public let meta: ProductMeta
    /// The relationships this product has
    public let relationships: Relationships?

    /// The main image of this product
    public var mainImage: File?
    /// The files this product has
    public var files: [File]?
    /// The categories this product belongs to
    public var categories: [Category]?
    /// The brands this product belongs to
    public var brands: [Brand]?
    /// The collections this product belongs to
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
        self.relationships = try container.decodeIfPresent(Relationships.self, forKey: .relationships)

        self.manageStock = try container.decode(Bool.self, forKey: .manageStock)
        self.commodityType = try container.decode(String.self, forKey: .commodityType)

        try self.decodeRelationships(fromRelationships: self.relationships, withIncludes: includes)

    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
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
