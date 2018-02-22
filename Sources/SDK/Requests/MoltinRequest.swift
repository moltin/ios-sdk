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
    internal var auth: MoltinAuth
    
    // MARK: - Init
    
    public init(withConfiguration configuration: MoltinConfig) {
        self.config = configuration
        self.http = MoltinHTTP(withSession: URLSession.shared)
        self.parser = MoltinParser()
        self.query = MoltinQuery()
        self.auth = MoltinAuth(withConfiguration: self.config)
    }
    
    // MARK: - Default Calls
    
    func list<T>(withPath path: String, completionHandler: @escaping CollectionRequestHandler<T>) {
        let urlRequest: URLRequest
        do {
            urlRequest = try self.http.buildURLRequest(
                withConfiguration: self.config,
                withPath: path,
                withQueryParameters: self.query.toURLQueryItems()
            )
        } catch {
            completionHandler(.failure(error: error))
            return
        }
        
        self.send(withURLRequest: urlRequest) { [weak self] (data, response, error) in
            self?.parser.collectionHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }
    }
    
    func get<T: Codable>(withPath path: String, completionHandler: @escaping ObjectRequestHandler<T>) {
        let urlRequest: URLRequest
        do {
            urlRequest = try self.http.buildURLRequest(
                withConfiguration: self.config,
                withPath: path,
                withQueryParameters: self.query.toURLQueryItems()
            )
        } catch {
            completionHandler(.failure(error: error))
            return
        }
        
        self.send(withURLRequest: urlRequest) { [weak self] (data, response, error) in
            self?.parser.singleObjectHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }
    }
    
    private func send(withURLRequest urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        self.auth.authenticate { (result) in
            switch result {
            case .success(_):
                self.http.executeRequest(urlRequest) { (data, response, error) in
                    completionHandler(data, response, error)
                }
            case .failure(let error):
                completionHandler(nil, nil, error)
            }
        }
    }
    
    // MARK: - Modifiers
    
    public func include(_ includes: [MoltinInclude]) -> Self {
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
    
    public func filter(operator op: MoltinFilterOperator, key: String, value: String) -> Self {
        self.query.withFilter.append((op, key, value))
        return self
    }
}
