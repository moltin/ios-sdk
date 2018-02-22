//
//  Parser.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

class MoltinParser {
    
    func singleObjectHandler<T: Codable>(withData data: Data?, withResponse: URLResponse?, completionHandler: @escaping ObjectRequestHandler<T>) {
        guard let data = data else {
            completionHandler(Result.failure(error: MoltinError.noData))
            return
        }
        let object: T = self.parseObject(data: data)
        completionHandler(Result.success(result: object))
    }
    
    func collectionHandler<T>(withData data: Data?, withResponse: URLResponse?, completionHandler: @escaping CollectionRequestHandler<T>) {
        guard let data = data else {
            completionHandler(Result.failure(error: MoltinError.noData))
            return
        }
        let paginatedResponse: PaginatedResponse<T> = self.parseCollection(data: data)
        completionHandler(Result.success(result: paginatedResponse))
    }
    
    private func parseCollection<T: Codable>(data: Data) -> PaginatedResponse<T> {
        let collection: PaginatedResponse<T> = try! JSONDecoder().decode(PaginatedResponse<T>.self, from: data)
        return collection
    }
    
    private func parseObject<T: Codable>(data: Data) -> T {
        let object: T = try! JSONDecoder().decode(T.self, from: data)
        return object
    }
}
