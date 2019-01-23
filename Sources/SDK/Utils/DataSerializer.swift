//
//  DataSerializer.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

protocol DataSerializer {
    func serialize(_ data: Any) throws -> Data
    func deserialize(_ data: Data?) throws -> Any
}

class MoltinDataSerializer: DataSerializer {

    func serialize(_ data: Any) throws -> Data {
        let payload: [String: Any] = ["data": data]
        return try JSONSerialization.data(withJSONObject: payload, options: [])
    }

    func deserialize(_ data: Data?) throws -> Any {
        guard let data = data else { return [:] }
        return try JSONSerialization.jsonObject(with: data, options: [])
    }
}
