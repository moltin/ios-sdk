//
//  File.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

public struct FileDimensions: Codable {
    public let width: Float
    public let height: Float
}

public class FileMeta: Codable {
    public let dimensions: FileDimensions
    public let timestamps: Timestamps
}

public class File: Codable {
    public let id: String
    public let type: String
    public let fileName: String
    public let mimeType: String
    public let fileSize: Int
    public let `public`: Bool
    public let link: [String: String]
    public let links: [String: String]
    public let meta: FileMeta
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case fileName = "file_name"
        case mimeType = "mime_type"
        case fileSize = "file_size"
        case `public`
        case link
        case links
        case meta
    }
}
