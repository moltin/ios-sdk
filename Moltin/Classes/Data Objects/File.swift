//
//  File.swift
//  Pods
//
//  Created by Oliver Foggin on 20/02/2017.
//
//

import Foundation
import Gloss

protocol HasFiles {
    var files: [File] { get set }
    mutating func addFiles(fromJSON json: [JSON], requiredIDs: [String])
}

extension HasFiles {
    mutating func addFiles(fromJSON json: [JSON], requiredIDs: [String]) {
        self.files = includedObjectsArray(fromJSONArray: json, requiredIDs: requiredIDs)
    }
}

public struct File {
    public let id: String
    public let url: URL
    public let fileName: String
}

extension File: JSONAPIDecodable {
    public init?(json: JSON, includedJSON: JSON?) {
        guard let id: String = "id" <~~ json,
            let urlString: String = "link.href" <~~ json,
            let url = URL(string: urlString),
            let fileName: String = "file_name" <~~ json else {
                return nil
        }
        
        self.id = id
        self.url = url
        self.fileName = fileName
    }
}
