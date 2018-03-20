//
//  Moltin.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

public class Moltin {
    public var config: MoltinConfig
    
    public var brand: BrandRequest {
        return BrandRequest(withConfiguration: self.config)
    }
    
    public var cart: CartRequest {
        return CartRequest(withConfiguration: self.config)
    }
    
    public var category: CategoryRequest {
        return CategoryRequest(withConfiguration: self.config)
    }
    
    public var collection: CollectionRequest {
        return CollectionRequest(withConfiguration: self.config)
    }
    
    public var currency: CurrencyRequest {
        return CurrencyRequest(withConfiguration: self.config)
    }
    
    public var file: FileRequest {
        return FileRequest(withConfiguration: self.config)
    }
    
    public var flow: FlowRequest {
        return FlowRequest(withConfiguration: self.config)
    }
    
    public var product: ProductRequest {
        return ProductRequest(withConfiguration: self.config)
    }
    
    public init(withClientID clientID: String, withConfiguration configuration: MoltinConfig? = nil) {
        self.config = configuration ?? MoltinConfig.default(withClientID: clientID)
    }
}
