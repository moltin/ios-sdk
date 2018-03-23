//
//  Customer.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

public class Customer: Codable {
    public var id: String?
    public var email: String?
    public var name: String?
    
    init(withID id: String? = nil, withEmail email: String? = nil, withName name: String? = nil) {
        self.id = id
        self.email = email
        self.name = name
    }
}
