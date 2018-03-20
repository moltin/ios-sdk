//
//  Category.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

public class Category: Codable {
    var id: String
    
    internal init(withID id: String) {
        self.id = id
    }
}
