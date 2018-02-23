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
        
        do {
            let object: T = try self.parseObject(data: data)
            completionHandler(Result.success(result: object))
        } catch {
            completionHandler(Result.failure(error: error))
        }
    }
    
    func collectionHandler<T>(withData data: Data?, withResponse: URLResponse?, completionHandler: @escaping CollectionRequestHandler<T>) {
        guard let data = data else {
            completionHandler(Result.failure(error: MoltinError.noData))
            return
        }
        do {
            let paginatedResponse: PaginatedResponse<T> = try self.parseCollection(data: data)
            completionHandler(Result.success(result: paginatedResponse))
        } catch {
            completionHandler(Result.failure(error: error))
        }
    }
    
    private func parseCollection<T: Codable>(data: Data) throws  -> PaginatedResponse<T> {
        let collection: PaginatedResponse<T>
        do {
            collection = try JSONDecoder().decode(PaginatedResponse<T>.self, from: data)
        } catch {
            throw MoltinError.couldNotParseData
        }
        return collection
    }
    
    private func parseObject<T: Codable>(data: Data) throws -> T {
        let object: T
        do {
            object = try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw MoltinError.couldNotParseData
        }
        return object
    }
}
