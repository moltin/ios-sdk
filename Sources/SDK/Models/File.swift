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
    public let file_name: String
    public let mime_type: String
    public let file_size: Int
    public let `public`: Bool
    public let link: [String: String]
    public let links: [String: String]
    public let meta: FileMeta
}
