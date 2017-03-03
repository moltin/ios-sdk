//
//  File.swift
//  Pods
//
//  Created by Oliver Foggin on 20/02/2017.
//
//

import Foundation
import Gloss

public struct FileDimensions {
    public let width: Int
    public let height: Int
}

public struct File {
    public let id: String
    public let url: URL
    public let fileName: String
    public let mimeType: String
    public let fileSize: Int
    public let isPublic: Bool
    public let dimensions: FileDimensions?
    public let json: JSON
}

extension File: JSONAPIDecodable {
    public init?(json: JSON, includedJSON: [String : JSON]?) {
        guard let id: String = "id" <~~ json,
            let urlString: String = "link.href" <~~ json,
            let url = URL(string: urlString),
            let fileName: String = "file_name" <~~ json,
            let mimeType: String = "mime_type" <~~ json,
            let fileSize: Int = "file_size" <~~ json,
            let isPublic: Bool = "public" <~~ json else {
                return nil
        }
        
        self.id = id
        self.url = url
        self.fileName = fileName
        self.mimeType = mimeType
        self.fileSize = fileSize
        self.isPublic = isPublic
        self.json = json
        
        if let width: Int = "meta.dimensions.width" <~~ json,
            let height: Int = "meta.dimensions.height" <~~ json {
            self.dimensions = FileDimensions(width: width, height: height)
        } else {
            self.dimensions = nil
        }
    }
}
