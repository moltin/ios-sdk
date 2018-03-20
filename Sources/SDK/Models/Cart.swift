//
//  Cart.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

public class CartMeta: Codable {
    public let displayPrice: DisplayPrices
    
    enum CodingKeys: String, CodingKey {
        case displayPrice = "display_price"
    }
}

public struct CartItemDisplayPrice: Codable {
    public let unit: DisplayPrice
    public let value: DisplayPrice
}

public struct CartItemDisplayPrices: Codable {
    public let withTax: CartItemDisplayPrice
    public let withoutTax: CartItemDisplayPrice
    
    enum CodingKeys: String, CodingKey {
        case withTax = "with_tax"
        case withoutTax = "without_tax"
    }
}

public class CartItemMeta: Codable {
    public let displayPrice: CartItemDisplayPrices
    
    enum CodingKeys: String, CodingKey {
        case displayPrice = "display_price"
    }
}

public class Cart: Codable {
    public let id: String
    public let type: String
    public let links: [String: String]
    public let meta: CartMeta
}

public class CartItem: Codable {
    public let id: String
    public let type: String
    public let product_id: String
    public let name: String
    public let description: String
    public let sku: String
    public let quantity: Int
    public let manage_stock: Bool
    public let unit_price: ProductPrice
    public let value: ProductPrice
    public let links: [String: String]
    public let meta: CartItemMeta
}

public enum CartItemType: String {
    case cartItem = "cart_item"
    case promotionItem = "promotion_item"
}

public class CustomCartItem: Codable {
    var sku: String
    
    internal init(withSKU sku: String) {
        self.sku = sku
    }
}
