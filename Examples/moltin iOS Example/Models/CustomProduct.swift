//
//  CustomProduct.swift
//  moltin iOS Example
//
//  Created by Craig Tweedy on 29/03/2018.
//

import UIKit
import moltin

class CustomProduct: Product {
    var backgroundColor: UIColor?
    
    enum ProductCodingKeys : String, CodingKey {
        case backgroundColor = "background_colour"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductCodingKeys.self)
        let color: String = try container.decode(String.self, forKey: .backgroundColor)
        self.backgroundColor = UIColor(hexString: color)
        try super.init(from: decoder)
    }
}
