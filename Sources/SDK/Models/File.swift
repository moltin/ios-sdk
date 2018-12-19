//
//  File.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

/// The dimensions of a `File`
public struct FileDimensions: Codable {
    /// The width of the file
    public let width: Float?
    /// The height of the file
    public let height: Float?

}

/// The meta information for a `File`
public class FileMeta: Codable {
    /// The dimensions for a `File`
    public let dimensions: FileDimensions?
    /// The timsestamps for a `File`
    public let timestamps: Timestamps
}

/// Represents a `File` in Moltin
open class File: Codable {
    /// The id of this file
    public var id: String
    /// The type of object
    public let type: String
    /// The name of this file
    public let fileName: String
    /// The MIME type of this fiel
    public let mimeType: String
    /// The file size of this file
    public let fileSize: Int
    /// Whether this file is public or not
    public let `public`: Bool
    /// The source link of this file
    public let link: [String: String]
    /// The external links of this file
    public let links: [String: String]
    /// The meta information for this file
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
