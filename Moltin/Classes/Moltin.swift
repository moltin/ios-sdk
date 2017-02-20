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
    
//    public static let collection = CollectionRequest()
    public static let product = ProductRequest()
//    public static let currency = CurrencyRequest()
    
    init() {
        fatalError("Do not instantiate Moltin, it is only used as an interface.")
    }
}
