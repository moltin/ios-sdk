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
    init?(json: JSON, includedJSON includes: [String : JSON]?)
    func relatedObjects<T: JSONAPIDecodable>(fromJSON json: JSON, withKeyPath keyPath: String, includedJSON includes: [String : JSON]?) -> [T]
}

extension JSONAPIDecodable {
    func relatedObjects<T: JSONAPIDecodable>(fromJSON json: JSON, withKeyPath keyPath: String, includedJSON includes: [String : JSON]?) -> [T] {
        guard let includes = includes,
            let relationshipJSON: [JSON] = keyPath <~~ json else {
                return []
        }
        
        return relationshipJSON
            .flatMap { $0["id"] as? String }
            .flatMap {
                guard let json = includes[$0] else {
                    return nil
                }
                
                return T(json: json, includedJSON: nil)
        }
    }
}

extension Array where Element: JSONAPIDecodable {
    static func from(jsonArray: [JSON], includedJSON: [String : JSON]?) -> [Element] {
        return jsonArray.flatMap {
            Element(json: $0, includedJSON: includedJSON)
        }
    }
}
