//
//  Cart.swift
//  Pods
//
//  Created by Oliver Foggin on 20/02/2017.
//
//

import Foundation
import Gloss

public struct Cart {
    public let id: String
    public let json: JSON
}

extension Cart : JSONAPIDecodable {
    public init?(json: JSON, includedJSON: [String : JSON]?) {
        guard let id: String = "id" <~~ json else {
                return nil
        }
        
        self.id = id
        self.json = json
    }
}
