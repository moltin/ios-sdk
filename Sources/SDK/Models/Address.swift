//
//  Address.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

public class Address: Codable {
    var line_1: String
    
    internal init(withAddressLine1 line_1: String) {
        self.line_1 = line_1
    }
}
