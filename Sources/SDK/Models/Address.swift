//
//  Address.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

/// Represents a `Address` in Moltin
open class Address: Codable {
    /// The ID of this address
    public var id: String?
    /// The type of this object
    public let type: String = "address"
    /// The first name for the person at this address
    public var firstName: String
    /// The last name for the person at this address
    public var lastName: String
    /// The display name of this address
    public var name: String?
    /// The delivery instructions for this address
    public var instructions: String?
    /// The company name at this address
    public var companyName: String?
    /// The first line for this address
    public var line1: String?
    /// The second line for this address
    public var line2: String?
    /// The city for this address
    public var city: String?
    /// The county for this address
    public var county: String?
    /// The postcode for this address
    public var postcode: String?
    /// The country for this address
    public var country: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "firstName"
        case lastName = "lastName"
        case companyName = "company_name"
        case line1 = "line_1"
        case line2 = "line_2"
        
        case id
        case type
        case name
        case instructions
        case city
        case county
        case postcode
        case country
    }
    
    init(
        withFirstName firstName: String,
        withLastName lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}
