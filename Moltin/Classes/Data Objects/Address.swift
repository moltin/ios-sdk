//
//  Address.swift
//  Pods
//
//  Created by Oliver Foggin on 22/02/2017.
//
//

import Foundation

import Gloss

public struct Address {
    public let firstName: String
    public let lastName: String
    public let companyName: String?
    public let line1: String
    public let line2: String?
    public let postcode: String
    public let county: String
    public let country: String
    public let shippingInstructions: String?
    public let json: JSON
    
    public init(firstName: String,
                lastName: String,
                companyName: String?,
                line1: String,
                line2: String?,
                postcode: String,
                county: String,
                country: String,
                shippingInstructions: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.companyName = companyName
        self.line1 = line1
        self.line2 = line2
        self.postcode = postcode
        self.county = county
        self.country = country
        self.shippingInstructions = shippingInstructions
        self.json = [:]
    }
    
    func dictionaryRepresentation(includeInstructions: Bool) -> [String : String] {
        var dictionary = [
            "first_name" : firstName,
            "last_name" : lastName,
            "line_1" : line1,
            "postcode" : postcode,
            "county" : county,
            "country" : country
        ]
        
        dictionary["company_name"] = companyName
        dictionary["line_2"] = line2
        
        if includeInstructions {
            dictionary["instructions"] = shippingInstructions
        }
        
        return dictionary
    }
}

extension Address: JSONAPIDecodable {
    init?(json: JSON, includedJSON: [String : JSON]?) {
        guard let firstName: String = "first_name" <~~ json,
            let lastName: String = "last_name" <~~ json,
            let line1: String = "line_1" <~~ json,
            let postcode: String = "postcode" <~~ json,
            let county: String = "county" <~~ json,
            let country: String = "country" <~~ json else {
                return nil
        }
        
        self.firstName = firstName
        self.lastName = lastName
        self.companyName = "company_name" <~~ json
        self.line1 = line1
        self.line2 = "line_2" <~~ json
        self.postcode = postcode
        self.county = county
        self.country = country
        self.shippingInstructions = "instructions" <~~ json
        self.json = json
    }
}
