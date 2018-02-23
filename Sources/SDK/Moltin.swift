//
//  Moltin.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

public class Moltin {
    public var config: MoltinConfig
    
    lazy public var brand: BrandRequest = {
        return BrandRequest(withConfiguration: self.config)
    }()
    
    lazy public var product: ProductRequest = {
        return ProductRequest(withConfiguration: self.config)
    }()
    
    public init(withClientID clientID: String, withConfiguration configuration: MoltinConfig? = nil) {
        self.config = configuration ?? MoltinConfig.default(withClientID: clientID)
    }
}
