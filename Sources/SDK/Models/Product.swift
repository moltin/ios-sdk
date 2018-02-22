//
//  Product.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

public class Product: Codable {
    var id: String
    
    internal init(withID id: String) {
        self.id = id
    }
}
