//
//  Timestamps.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 20/03/2018.
//

import Foundation

public class Timestamps: Codable {
    public let createdAt: Date
    public let updatedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
