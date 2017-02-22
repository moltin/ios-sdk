//
//  JSONAPIDecodable.swift
//  Pods
//
//  Created by Oliver Foggin on 20/02/2017.
//
//

import Foundation
import Gloss

protocol JSONAPIDecodable {
    var json: JSON { get }
    init?(json: JSON, includedJSON: JSON?)
}

func includedObjectsArray<T: JSONAPIDecodable>(fromJSONArray jsonArray: [JSON], requiredIDs: [String]) -> [T] {
    let filteredJSON = jsonArray.filter {
        guard let id: String = "id" <~~ $0 else {
            return false
        }
        
        return requiredIDs.contains(id)
    }
    
    return [T].from(jsonArray: filteredJSON, includedJSON: nil)
}

extension Array where Element: JSONAPIDecodable {
    static func from(jsonArray: [JSON], includedJSON: JSON?) -> [Element] {
        var models: [Element] = []
        
        jsonArray.forEach {
            if let model = Element(json: $0, includedJSON: includedJSON) {
                models.append(model)
            }
        }
        
        return models
    }
}
