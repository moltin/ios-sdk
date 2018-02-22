//
//  Parser.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

class MoltinParser {
    
    func singleObjectHandler<T: Codable>(withData data: Data?, withResponse: URLResponse?, completionHandler: @escaping ObjectRequestHandler<T>) {
        let productJson = """
                {
                  "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                  "author": {
                    "name": "Craig"
                  }
                }
                """
        let jsonData = productJson.data(using: .utf8)!
        let object: T = self.parseObject(data: jsonData)
        completionHandler(Result.success(result: object))
    }
    
    func collectionHandler<T>(withData data: Data?, withResponse: URLResponse?, completionHandler: @escaping CollectionRequestHandler<T>) {
        let productJson = """
                {
                  "data":
                    [{
                      "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                      "author": {
                        "name": "Craig"
                      }
                    }],
                    "meta": {
                    }
                }
                """
        let jsonData = productJson.data(using: .utf8)!
        let paginatedResponse: PaginatedResponse<T> = self.parseCollection(data: jsonData)
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
