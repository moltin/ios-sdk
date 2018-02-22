//
//  MoltinRequest.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

public enum Result<T> {
    case success(result: T)
    case failure(error: Error)
}

public class MoltinRequest {
    
    internal var config: MoltinConfig
    internal var http: MoltinHTTP
    internal var parser: MoltinParser
    
    private var endpoint: String = ""
    
    internal var query: MoltinQuery
    
    // MARK: - Init
    
    public init(withConfiguration configuration: MoltinConfig) {
        self.config = configuration
        self.http = MoltinHTTP(withSession: URLSession.shared)
        self.parser = MoltinParser()
        self.query = MoltinQuery()
    }
    
    // MARK: - Default Calls
    
    public func all<T>(completionHandler: @escaping CollectionRequestHandler<T>) {
        let urlRequest: URLRequest
        do {
            urlRequest = try self.http.buildURLRequest(
                withConfiguration: self.config,
                withPath: self.endpoint,
                withQueryParameters: self.query.toURLQueryItems()
            )
        } catch MoltinError.unacceptableRequest {
            completionHandler(.failure(error: MoltinError.unacceptableRequest))
            return
        } catch {
            completionHandler(.failure(error: error))
            return
        }
        
        self.http.executeRequest(urlRequest) { [weak self] (data, response) in
            self?.parser.collectionHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }
    }
    
    public func get<T: Codable>(forID id: String, completionHandler: @escaping ObjectRequestHandler<T>) {
        let urlRequest: URLRequest
        do {
            urlRequest = try self.http.buildURLRequest(
                withConfiguration: self.config,
                withPath: "/\(self.endpoint)\(id)/",
                withQueryParameters: self.query.toURLQueryItems()
            )
        } catch MoltinError.unacceptableRequest {
            completionHandler(.failure(error: MoltinError.unacceptableRequest))
            return
        } catch {
            completionHandler(.failure(error: error))
            return
        }
        
        self.http.executeRequest(urlRequest) { [weak self] (data, response) in
            self?.parser.singleObjectHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }
    }
    
    // MARK: - Modifiers
    
    public func include(_ includes: [MoltinQuery.Include]) -> Self {
        self.query.withIncludes = includes
        return self
    }
    
    public func limit(_ limit: Int) -> Self {
        self.query.withLimit = "\(limit)"
        return self
    }
    
    public func sort(_ sort: String) -> Self {
        self.query.withSorting = sort
        return self
    }
    
    public func offset(_ offset: Int) -> Self {
        self.query.withOffset = "\(offset)"
        return self
    }
    
    public func filter(operator op: String, key: String, value: String) -> Self {
        self.query.withFilter.append((op, key, value))
        return self
    }
}
