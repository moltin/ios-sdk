//
//  Cart.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

public class Cart: Codable {
    var id: String
    var items: [CartItem] = []
    
    internal init(withID id: String) {
        self.id = id
    }
}

public class CartItem: Codable {
    var id: String
    var quantity: Int = 0
    
    internal init(withID id: String) {
        self.id = id
    }
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
