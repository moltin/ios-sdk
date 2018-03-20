//
//  Customer.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

public class Customer: Codable {
    let id: String
    
    internal init(withID id: String) {
        self.id = id
    }
}
