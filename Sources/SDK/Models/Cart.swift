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

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// The display price for a `CartItem`
public struct CartItemDisplayPrice: Codable {
    /// The unit price for a cart item
    public let unit: DisplayPrice
    /// The value price (based on quantity) for a cart item
    public let value: DisplayPrice

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// The display prices information for a `CartItem`
public struct CartItemDisplayPrices: Codable {
    /// The display price for this cart item including tax
    public let withTax: CartItemDisplayPrice
    /// The display price for this cart item without tax
    public let withoutTax: CartItemDisplayPrice

    enum CodingKeys: String, CodingKey {
        case withTax = "with_tax"
        case withoutTax = "without_tax"
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// The meta information for this `CartItem`
public class CartItemMeta: Codable {
    /// The display price for this cart item
    public let displayPrice: CartItemDisplayPrices

    enum CodingKeys: String, CodingKey {
        case displayPrice = "display_price"
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}

/// Represents a `Cart` in Moltin
open class Cart: Codable {
    /// The id for this cart
    public let id: String
    /// The type of this object
    public let type: String
    /// The external links for this cart
    public let links: [String: String]
    /// The meta information for this cart
    public let meta: CartMeta

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
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
    /// The external links for this cart item
    public let links: [String: String]
    /// The meta information for this cart
    public let meta: CartItemMeta

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
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
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

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}
