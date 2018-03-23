//
//  MoltinRequest.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

enum HTTPMethod: String, CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
    
    case GET
    case POST
    case PUT
    case DELETE
}

public enum Result<T> {
    case success(result: T)
    case failure(error: Error)
}

public class MoltinRequest {
    
    internal var config: MoltinConfig
    internal var http: MoltinHTTP
    internal var parser: MoltinParser
    
    internal var query: MoltinQuery
    internal var auth: MoltinAuth
    
    // MARK: - Init
    
    public init(withConfiguration configuration: MoltinConfig) {
        self.config = configuration
        self.http = MoltinHTTP(withSession: URLSession.shared)
        self.parser = MoltinParser(withDecoder: JSONDecoder.dateFormattingDecoder())
        self.query = MoltinQuery()
        self.auth = MoltinAuth(withConfiguration: self.config)
    }
    
    // MARK: - Default Calls
    
    func list<T>(withPath path: String, completionHandler: @escaping CollectionRequestHandler<T>) -> Self {
        let urlRequest: URLRequest
        do {
            urlRequest = try self.http.buildURLRequest(
                withConfiguration: self.config,
                withPath: path,
                withQueryParameters: self.query.toURLQueryItems()
            )
        } catch {
            completionHandler(.failure(error: error))
            return self
        }
        
        self.send(withURLRequest: urlRequest) { [weak self] (data, response, error) in
            self?.parser.collectionHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }
        
        return self
    }
    
    func get<T: Codable>(withPath path: String, completionHandler: @escaping ObjectRequestHandler<T>) -> Self {
        let urlRequest: URLRequest
        do {
            urlRequest = try self.http.buildURLRequest(
                withConfiguration: self.config,
                withPath: path,
                withQueryParameters: self.query.toURLQueryItems()
            )
        } catch {
            completionHandler(.failure(error: error))
            return self
        }
        
        self.send(withURLRequest: urlRequest) { [weak self] (data, response, error) in
            self?.parser.singleObjectHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }
        
        return self
    }
    
    func post<T: Codable>(withPath path: String, withData data: [String : Any], completionHandler: @escaping ObjectRequestHandler<T>) -> Self {
        let urlRequest: URLRequest
        do {
            urlRequest = try self.http.buildURLRequest(
                withConfiguration: self.config,
                withPath: path,
                withQueryParameters: self.query.toURLQueryItems(),
                withMethod: HTTPMethod.POST,
                withData: data
            )
        } catch {
            completionHandler(.failure(error: error))
            return self
        }
        
        self.send(withURLRequest: urlRequest) { [weak self] (data, response, error) in
            self?.parser.singleObjectHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }
        
        return self
    }
    
    func put<T: Codable>(withPath path: String, withData data: [String : Any], completionHandler: @escaping ObjectRequestHandler<T>) -> Self {
        let urlRequest: URLRequest
        do {
            urlRequest = try self.http.buildURLRequest(
                withConfiguration: self.config,
                withPath: path,
                withQueryParameters: self.query.toURLQueryItems(),
                withMethod: HTTPMethod.PUT,
                withData: data
            )
        } catch {
            completionHandler(.failure(error: error))
            return self
        }
        
        self.send(withURLRequest: urlRequest) { [weak self] (data, response, error) in
            self?.parser.singleObjectHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }
        
        return self
    }
    
    func delete<T: Codable>(withPath path: String, completionHandler: @escaping ObjectRequestHandler<T>) -> Self {
        let urlRequest: URLRequest
        do {
            urlRequest = try self.http.buildURLRequest(
                withConfiguration: self.config,
                withPath: path,
                withQueryParameters: self.query.toURLQueryItems(),
                withMethod: HTTPMethod.DELETE
            )
        } catch {
            completionHandler(.failure(error: error))
            return self
        }
        
        self.send(withURLRequest: urlRequest) { [weak self] (data, response, error) in
            self?.parser.singleObjectHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }
        
        return self
    }
    
    private func send(withURLRequest urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        self.auth.authenticate { [weak self] (result) in
            switch result {
            case .success(let result):
                let request = self?.http.configureRequest(urlRequest, withToken: result.token, withConfig: self?.config)
                self?.http.executeRequest(request) { (data, response, error) in
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
