//
//  Customer.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

/// Represents a `Customer` in Moltin
open class Customer: Codable {
    /// The ID of this customer
    public var id: String?
    /// The email of this customer
    public var email: String?
    /// The name of this customer
    public var name: String?

    /// Initialise a new customer for checking out with
    public init(withID id: String? = nil, withEmail email: String? = nil, withName name: String? = nil) {
        self.id = id
        self.email = email
        self.name = name
    }

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }

    func toDictionary() -> [String: Any] {
        var customerData: [String: Any] = [:]
        if let id = self.id {
            customerData["id"] = id
        } else {
            customerData["email"] = self.email
            customerData["name"] = self.name
        }

        return customerData
    }
}
