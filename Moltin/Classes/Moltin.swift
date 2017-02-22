//
//  Moltin.swift
//  Moltin
//
//  Created by Oliver Foggin on 14/02/2017.
//  Copyright © 2017 Oliver Foggin. All rights reserved.
//

import Foundation

public struct Moltin {
    public static var clientID: String? = nil
    
    public static var currencyCode: String? = nil
    public static var language: String? = nil
    public static var locale: String? = nil
    
    public static let brand = BrandRequest()
    public static let cart = CartRequest()
    public static let category = CategoryRequest()
    public static let checkout = CheckoutRequest()
    public static let collection = CollectionRequest()
    public static let currency = CurrencyRequest()
    public static let file = FileRequest()
    public static let product = ProductRequest()
    
    init() {
        fatalError("Do not instantiate Moltin, it is only used as an interface.")
    }
}
