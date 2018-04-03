//
//  DataSerializer.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import Foundation

protocol DataSerializer {
    func serialize(_ data: Any) throws -> Data
}

class MoltinDataSerializer: DataSerializer {

    func serialize(_ data: Any) throws -> Data {
        let payload: [String: Any] = ["data": data]
        return try JSONSerialization.data(withJSONObject: payload, options: [])
    }
}
