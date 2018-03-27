//
//  Customer.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

/// Represents a `Customer` in Moltin
public class Customer: Codable {
    /// The ID of this customer
    public var id: String?
    /// The email of this customer
    public var email: String?
    /// The name of this customer
    public var name: String?
    
    init(withID id: String? = nil, withEmail email: String? = nil, withName name: String? = nil) {
        self.id = id
        self.email = email
        self.name = name
    }
}
