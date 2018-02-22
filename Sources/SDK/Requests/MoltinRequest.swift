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
        } catch MoltinError.unacceptableRequest {
            completionHandler(.failure(error: MoltinError.unacceptableRequest))
            return
        } catch {
            completionHandler(.failure(error: error))
            return
        }
        
        self.auth.authenticate { (result) in
            switch result {
            case .success(_):
                self.http.executeRequest(urlRequest) { [weak self] (data, response, error) in
                    self?.parser.collectionHandler(withData: data, withResponse: response, completionHandler: completionHandler)
                }
            case .failure(let error):
                completionHandler(.failure(error: error))
            }
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
        } catch MoltinError.unacceptableRequest {
            completionHandler(.failure(error: MoltinError.unacceptableRequest))
            return
        } catch {
            completionHandler(.failure(error: error))
            return
        }
        
        self.auth.authenticate { (result) in
            switch result {
            case .success(_):
                self.http.executeRequest(urlRequest) { [weak self] (data, response, error) in
                    self?.parser.singleObjectHandler(withData: data, withResponse: response, completionHandler: completionHandler)
                }
            case .failure(let error):
                completionHandler(.failure(error: error))
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
    
    public func filter(operator op: String, key: String, value: String) -> Self {
        self.query.withFilter.append((op, key, value))
        return self
    }
}
