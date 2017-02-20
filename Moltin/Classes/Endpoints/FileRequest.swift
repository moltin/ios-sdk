//
//  FileRequest.swift
//  Pods
//
//  Created by Oliver Foggin on 20/02/2017.
//
//

import Foundation

public struct FileRequest {
    public func list(withQuery query: MoltinQuery? = nil, completion: @escaping (Result<[File]>) -> ()) {
        MoltinAPI.arrayRequest(request: Router.listFiles(query: query), completion: completion)
    }
    
    public func get(withFileID id: String, include: [MoltinQuery.Include]? = nil, completion: @escaping (Result<File?>) -> ()) {
        MoltinAPI.objectRequest(request: Router.getFile(id: id), completion: completion)
    }
}
