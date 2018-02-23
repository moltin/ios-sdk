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

public protocol BaseRequest {
    func list<T>(withPath path: String, completionHandler: @escaping CollectionRequestHandler<T>)
    func get<T: Codable>(withPath path: String, completionHandler: @escaping ObjectRequestHandler<T>)
    
    func post<T: Codable>(withPath path: String, withData data: [String: Any], completionHandler: @escaping ObjectRequestHandler<T>)
    func put<T: Codable>(withPath path: String, withData data: [String: Any], completionHandler: @escaping ObjectRequestHandler<T>)
    func delete<T: Codable>(withPath path: String, completionHandler: @escaping ObjectRequestHandler<T>)
}

public protocol Request: BaseRequest {
    var endpoint: String { get }
    
    associatedtype ContainedType: Codable
    
    typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[ContainedType]>
    typealias DefaultObjectRequestHandler = ObjectRequestHandler<ContainedType>
    
    func all(completionHandler: @escaping DefaultCollectionRequestHandler)
    func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler)
}

extension Request {
    
    public func all(completionHandler: @escaping DefaultCollectionRequestHandler) {
        self.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }
    
    public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) {
        self.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }
    
}

public protocol CustomTypeRequest: Request {
    func all<T: Codable>(completionHandler: @escaping CollectionRequestHandler<[T]>)
    func get<T: Codable>(forID id: String, completionHandler: @escaping ObjectRequestHandler<T>)
}

extension CustomTypeRequest {
    
    public func all<T: Codable>(completionHandler: @escaping CollectionRequestHandler<[T]>) {
        self.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }
    
    public func get<T: Codable>(forID id: String, completionHandler: @escaping ObjectRequestHandler<T>) {
        self.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }
}

public protocol TreeRequest: Request {
    func tree(completionHandler: @escaping DefaultCollectionRequestHandler)
}

extension TreeRequest {
    
    public func tree(completionHandler: @escaping DefaultCollectionRequestHandler) {
        self.list(withPath: "\(self.endpoint)/tree", completionHandler: completionHandler)
    }
    
}

public protocol CustomTypeTreeRequest: Request {
    func tree<T: Codable>(completionHandler: @escaping CollectionRequestHandler<[T]>)
}

extension CustomTypeTreeRequest {
    
    public func tree<T: Codable>(completionHandler: @escaping CollectionRequestHandler<[T]>) {
        self.list(withPath: "\(self.endpoint)/tree", completionHandler: completionHandler)
    }
    
}

public class MoltinRequest: BaseRequest {
    
    internal var config: MoltinConfig
    internal var http: MoltinHTTP
    internal var parser: MoltinParser
    
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
    
    public func list<T>(withPath path: String, completionHandler: @escaping CollectionRequestHandler<T>) {
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
            guard let strongSelf = self else {
                completionHandler(.failure(error: MoltinError.referenceLost))
                return
            }
            strongSelf.parser.collectionHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }
    }
    
    public func get<T: Codable>(withPath path: String, completionHandler: @escaping ObjectRequestHandler<T>) {
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
    
    public func post<T: Codable>(withPath path: String, withData data: [String : Any], completionHandler: @escaping ObjectRequestHandler<T>) {
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
            return
        }
        
        self.send(withURLRequest: urlRequest) { [weak self] (data, response, error) in
            self?.parser.singleObjectHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }
    }
    
    public func put<T: Codable>(withPath path: String, withData data: [String : Any], completionHandler: @escaping ObjectRequestHandler<T>) {
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
            return
        }
        
        self.send(withURLRequest: urlRequest) { [weak self] (data, response, error) in
            self?.parser.singleObjectHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }
    }
    
    public func delete<T: Codable>(withPath path: String, completionHandler: @escaping ObjectRequestHandler<T>) {
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
            return
        }
        
        self.send(withURLRequest: urlRequest) { [weak self] (data, response, error) in
            self?.parser.singleObjectHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }
    }
    
    private func send(withURLRequest urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        self.auth.authenticate { [weak self] (result) in
            guard let strongSelf = self else {
                completionHandler(nil, nil, MoltinError.referenceLost)
                return
            }
            switch result {
            case .success(_):
                let request = strongSelf.http.configureRequest(urlRequest, withAuth: strongSelf.auth)
                strongSelf.http.executeRequest(request) { (data, response, error) in
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
