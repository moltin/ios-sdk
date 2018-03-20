//
//  Parser.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

class MoltinParser {
    
    var decoder: JSONDecoder
    
    init(withDecoder decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
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
            collection = try self.decoder.decode(PaginatedResponse<T>.self, from: data)
        } catch {
            throw MoltinError.couldNotParseData(underlyingError: error as? DecodingError)
        }
        return collection
    }
    
    private func parseObject<T: Codable>(data: Data) throws -> T {
        let object: T
        do {
            object = try self.decoder.decode(T.self, from: data)
        } catch {
            throw MoltinError.couldNotParseData(underlyingError: error as? DecodingError)
        }
        return object
    }
}
