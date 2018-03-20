//
//  Product.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

class ProductPrice: Codable {
    var amount: Int = 0
    var currency: String = ""
    var includes_tax: Bool = false
}

class ProductTimestamps: Codable {
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}

class ProductStock: Codable {
    var level: Int = 0
    var availability: String = "out-stock"
}

class ProductDisplayPrice: Codable {
    var amount: Int = 0
    var currency: String = ""
    var formatted: String = ""
}

class ProductDisplayPrices: Codable {
    var withTax: ProductDisplayPrice = ProductDisplayPrice()
    var withoutTax: ProductDisplayPrice = ProductDisplayPrice()
}

class ProductVariationOption: Codable {
    var id: String = ""
    var name: String = ""
    var description: String = ""
}

class ProductVariation: Codable {
    var id: String = ""
    var options: [ProductVariationOption] = []
}

class ProductRelationshipMany: Codable {
    var data: [ProductRelationshipData] = []
}

class ProductRelationshipSingle: Codable {
    var data: ProductRelationshipData?
}

class ProductRelationshipData: Codable {
    var type: String = ""
    var id: String = ""
}

class ProductRelationships: Codable {
    var variations: ProductRelationshipMany?
    var files: ProductRelationshipMany?
    var main_image: ProductRelationshipSingle?
    var categories: ProductRelationshipMany?
    var collections: ProductRelationshipMany?
    var brands: ProductRelationshipMany?
}

class ProductMeta: Codable {
    var timestamps: ProductTimestamps = ProductTimestamps()
    var stock: ProductStock = ProductStock()
    var displayPrice: ProductDisplayPrices = ProductDisplayPrices()
    var variations: [ProductVariation] = []
    var variation_matrix: [String: String] = [:]
    var relationships: ProductRelationships = ProductRelationships()
}

public class Product: Codable {
    var id: String = ""
    var type: String = ""
    var name: String = ""
    var slug: String = ""
    var sku: String = ""
    var manageStock: Bool = false
    var description: String = ""
    var price: [ProductPrice] = []
    var status: String = ""
    var commodityType: String = ""
    var meta: ProductMeta = ProductMeta()
    
    internal init(withID id: String) {
        self.id = id
    }
}
