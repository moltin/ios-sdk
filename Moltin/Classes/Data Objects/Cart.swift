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
}

extension Cart : JSONAPIDecodable {
    public init?(json: JSON, includedJSON: JSON?) {
        guard let id: String = "id" <~~ json else {
                return nil
        }
        
        self.id = id
    }
}
