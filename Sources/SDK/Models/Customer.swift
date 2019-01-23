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

/// Represents a `CustomerToken` in Moltin
open class CustomerToken: Codable {
    /// The ID of this token
    public var id: String?
    /// The customer ID assigned to this token
    public var customerID: String?
    /// The JWT token
    public var token: String?
    /// The expiry timestamp
    public var expires: Int?

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customer_id"
        case token
        case expires
    }
}

/// A data object used to update customers with
open class UpdateCustomer {
    /// The ID of this customer
    public var id: String?
    /// The email of this customer
    public var email: String?
    /// The name of this customer
    public var name: String?
    /// The password of this customer
    public var password: String?

    func toDictionary() -> [String: Any] {
        var customerData: [String: Any] = [:]

        customerData["id"] = self.id
        customerData["email"] = self.email
        customerData["name"] = self.name
        customerData["password"] = self.password

        return customerData
    }
}
