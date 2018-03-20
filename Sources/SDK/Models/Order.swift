//
//  Order.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

public class Order: Codable {
    var id: String
    
    internal init(withID id: String) {
        self.id = id
    }
}
