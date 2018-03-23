//
//  Address.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

public class Address: Codable {
    public var id: String?
    public let type: String = "address"
    public var firstName: String
    public var lastName: String
    public var name: String?
    public var instructions: String?
    public var companyName: String?
    public var line1: String?
    public var line2: String?
    public var city: String?
    public var county: String?
    public var postcode: String?
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
