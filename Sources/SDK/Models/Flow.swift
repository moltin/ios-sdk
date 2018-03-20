//
//  Flow.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

public class Entry: Codable {
    public let id: String
    public let type: String
}

public struct FieldMeta: Codable {
    public let timestamps: Timestamps
}

public class Field: Codable {
    public let id: String
    public let type: String
    public let fieldType: String
    public let slug: String
    public let name: String
    public let description: String
    public let required: Bool
    public let unique: Bool
//    public let `default`: Any
    public let enabled: Bool
//    public let validationRules: [String: Any]
    public let links: [String: String]
    public let relationships: [String: [String: [String: String]]]
    public let meta: FieldMeta
}

public class Flow: Codable {
    public let id: String
    public let type: String
    public let name: String
    public let slug: String
    public let description: String
    public let enabled: Bool
}
