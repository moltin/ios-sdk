//
//  Cart.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

/// The meta information for a `Cart`
public class CartMeta: Codable {
    /// The display price information for this cart
    public let displayPrice: DisplayPrices

    enum CodingKeys: String, CodingKey {
        case displayPrice = "display_price"
    }
}

/// The display price for a `CartItem`
public struct CartItemDisplayPrice: Codable {
    /// The unit price for a cart item
    public let unit: DisplayPrice
    /// The value price (based on quantity) for a cart item
    public let value: DisplayPrice
}

/// The display prices information for a `CartItem`
public struct CartItemDisplayPrices: Codable {
    /// The display price for this cart item including tax
    public let withTax: CartItemDisplayPrice
    /// The display price for this cart item without tax
    public let withoutTax: CartItemDisplayPrice
    /// The display price for this cart item's tax amount
    public let tax: CartItemDisplayPrice

    enum CodingKeys: String, CodingKey {
        case withTax = "with_tax"
        case withoutTax = "without_tax"
        case tax
    }
}

/// The meta information for this `CartItem`
public class CartItemMeta: Codable {
    /// The display price for this cart item
    public let displayPrice: CartItemDisplayPrices

    enum CodingKeys: String, CodingKey {
        case displayPrice = "display_price"
    }
}

/// Represents a `Cart` in Moltin
open class Cart: Codable {
    /// The id for this cart
    public let id: String
    /// The type of this object
    public let type: String
    /// The external links for this cart
    public let links: [String: String]?
    /// The meta information for this cart
    public let meta: CartMeta?
}

/// Represents a `CartItem` in Moltin
open class CartItem: Codable {
    /// The id for this cart item
    public let id: String
    /// The type of this object
    public let type: String
    /// The product ID for this `CartItem`
    public let productId: String
    /// The name of this cart item
    public let name: String
    /// The description of this cart item
    public let description: String
    /// The SKU of this cart item
    public let sku: String
    /// The quantity of this cart item
    public let quantity: Int
    /// The price for this cart item
    public let unitPrice: ProductPrice
    /// The price for this cart item, taking into account quantity
    public let value: ProductPrice
    /// The tax for this cart item, taking into account quantity
    public var taxes: [TaxItem]?
    /// The external links for this cart item
    public let links: [String: String]
    /// The meta information for this cart item
    public let meta: CartItemMeta
    /// The relationships this item has
    public let relationships: Relationships?

    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case unitPrice = "unit_price"

        case id
        case type
        case name
        case description
        case sku
        case quantity
        case value
        case links
        case meta
        case relationships
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let includes: IncludesContainer = decoder.userInfo[.includes] as? IncludesContainer ?? [:]

        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decode(String.self, forKey: .type)
        self.productId = try container.decode(String.self, forKey: .productId)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.sku = try container.decode(String.self, forKey: .sku)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
        self.unitPrice = try container.decode(ProductPrice.self, forKey: .unitPrice)
        self.value = try container.decode(ProductPrice.self, forKey: .value)
        self.links = try container.decode([String: String].self, forKey: .links)
        self.meta = try container.decode(CartItemMeta.self, forKey: .meta)
        self.relationships = try? container.decode(Relationships.self, forKey: .relationships)

        try self.decodeRelationships(fromRelationships: self.relationships, withIncludes: includes)
    }
}

extension CartItem {

    func decodeRelationships(
        fromRelationships relationships: Relationships?,
        withIncludes includes: IncludesContainer
        ) throws {

        self.taxes = try self.decodeMany(
            fromRelationships: relationships?[keyPath: \Relationships.taxes],
            withIncludes: includes["tax_items"])

    }
}

/// Represents various types of cart items
public enum CartItemType: String {
    /// A standard cart item
    case cartItem = "cart_item"
    /// A promo item
    case promotionItem = "promotion_item"
}

/// A custom cart item
open class CustomCartItem: Codable {
    /// The SKU of this cart item
    var sku: String

    internal init(withSKU sku: String) {
        self.sku = sku
    }
}

/// A tax item
open class TaxItem: Codable {

    public let type: String
    public let id: String
    public let jurisdiction: String
    public let code: String
    public let name: String
    public let rate: Float
}
