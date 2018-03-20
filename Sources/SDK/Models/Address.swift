//
//  Address.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

public class Address: Codable {
    public let id: String
    public let type: String
    public let firstName: String
    public let lastName: String
    public let name: String
    public let instructions: String
    public let companyName: String
    public let line1: String
    public let line2: String
    public let city: String
    public let county: String
    public let postcode: String
    public let country: String
    
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
}
