//
//  Moltin.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

public class Moltin {
    public var config: MoltinConfig
    public var clientID: String
    
    public var product: ProductRequest {
        return ProductRequest(withConfiguration: self.config)
    }
    
    public init(withClientID clientID: String, withConfiguration configuration: MoltinConfig? = nil) {
        self.clientID = clientID
        
        self.config = configuration ?? MoltinConfig.default()
    }
}
