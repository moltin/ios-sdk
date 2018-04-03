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

/// Boxes up results into success or failure cases
/// This enum will either return success, with the corresponding value with the correct type, or return failure, with the corresponding error
public enum Result<T> {
    /// Holds the success result
    case success(result: T)
    /// Holds the failure error
    case failure(error: Error)
}

/// Base class which various endpoints extend from.
/// This class is responsible for orchestrating a request, by constructing queries, authenticating calls, and parsing data.
public class MoltinRequest {

    internal var config: MoltinConfig
    internal var http: MoltinHTTP
    internal var parser: MoltinParser

    internal var query: MoltinQuery
    internal var auth: MoltinAuth

    // MARK: - Init

    /**
     Initialise a new `MoltinRequest` with some standard configuration
     
     - Author:
     Craig Tweedy
     
     - parameters:
        - withConfiguration: A `MoltinConfig` object
    */
    public init(withConfiguration configuration: MoltinConfig) {
        self.config = configuration
        self.http = MoltinHTTP(withSession: URLSession.shared)
        self.parser = MoltinParser(withDecoder: JSONDecoder.dateFormattingDecoder())
        self.query = MoltinQuery()
        self.auth = MoltinAuth(withConfiguration: self.config)
    }

    // MARK: - Default Calls

    /**
     Return all instances of type `T`, which must be `Codable`.
     - Author:
        Craig Tweedy
    - parameters:
        - withPath: The resource path to call
        - completionHandler: The handler to be called on success or failure
     - returns:
     A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult func list<T>(withPath path: String, completionHandler: @escaping CollectionRequestHandler<T>) -> Self {
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

        self.send(withURLRequest: urlRequest) { (data, response, error) in
            if error != nil {
                completionHandler(.failure(error: MoltinError.responseError(underlyingError: error)))
                return
            }
            self.parser.collectionHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }

        return self
    }

    /**
     Return a single instance of type `T`, which must be `Codable`.
    - Author:
        Craig Tweedy
     - parameters:
        - withPath: The resource path to call
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult func get<T: Codable>(withPath path: String, completionHandler: @escaping ObjectRequestHandler<T>) -> Self {
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

        self.send(withURLRequest: urlRequest) { (data, response, error) in
            if error != nil {
                completionHandler(.failure(error: MoltinError.responseError(underlyingError: error)))
                return
            }
            self.parser.singleObjectHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }

        return self
    }

    /**
     Construct a creation request, and return an instance of type `T`, which must be `Codable`
     
     - Author:
     Craig Tweedy

     - parameters:
        - withPath: The resource path to call
        - withData: The data with which to create the resource
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult func post<T: Codable>(withPath path: String, withData data: [String: Any], completionHandler: @escaping ObjectRequestHandler<T>) -> Self {
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

        self.send(withURLRequest: urlRequest) { (data, response, error) in
            if error != nil {
                completionHandler(.failure(error: MoltinError.responseError(underlyingError: error)))
                return
            }
            self.parser.singleObjectHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }

        return self
    }

    /**
     Construct an update request, and return an instance of type `T`, which must be `Codable`
     
     - Author:
     Craig Tweedy
     
     - parameters:
        - withPath: The resource path to call
        - withData: The data with which to update the resource
        - completionHandler: The handler to be called on success or failure
     - returns:
     A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult func put<T: Codable>(withPath path: String, withData data: [String: Any], completionHandler: @escaping ObjectRequestHandler<T>) -> Self {
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

        self.send(withURLRequest: urlRequest) { (data, response, error) in
            if error != nil {
                completionHandler(.failure(error: MoltinError.responseError(underlyingError: error)))
                return
            }
            self.parser.singleObjectHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }

        return self
    }

    /**
     Construct a deletion request, and return an instance of type `T`, which must be `Codable`
     
     - Author:
     Craig Tweedy
     
     - parameters:
        - withPath: The resource path to call
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult func delete<T: Codable>(withPath path: String, completionHandler: @escaping ObjectRequestHandler<T>) -> Self {
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

        self.send(withURLRequest: urlRequest) { (data, response, error) in
            if error != nil {
                completionHandler(.failure(error: MoltinError.responseError(underlyingError: error)))
                return
            }
            self.parser.singleObjectHandler(withData: data, withResponse: response, completionHandler: completionHandler)
        }

        return self
    }

    private func send(withURLRequest urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
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

    /**
     Add some includes to the query
     
     - Author:
     Craig Tweedy
     
     - parameters:
        - includes: An array of `MoltinInclude` to append to the request
     
     - returns:
     A instance of `MoltinRequest` which encapsulates the request.
     */
    public func include(_ includes: [MoltinInclude]) -> Self {
        self.query.withIncludes = includes
        return self
    }

    /**
     Add a limit parameter to the query
     
     - Author:
        Craig Tweedy
     
     - parameters:
        - limit: The amount of items to return
     
     - returns:
     A instance of `MoltinRequest` which encapsulates the request.
     */
    public func limit(_ limit: Int) -> Self {
        self.query.withLimit = "\(limit)"
        return self
    }

    /**
     Add a sort parameter to the query
     
     - Author:
     Craig Tweedy
     
     - parameters:
        - sort: The sort order to use
     
     - returns:
     A instance of `MoltinRequest` which encapsulates the request.
     */
    public func sort(_ sort: String) -> Self {
        self.query.withSorting = sort
        return self
    }

    /**
     Add an offset parameter to the query
     
     - Author:
     Craig Tweedy
     
     - parameters:
        - offset: The amount of items to offset by
     
     - returns:
     A instance of `MoltinRequest` which encapsulates the request.
     */
    public func offset(_ offset: Int) -> Self {
        self.query.withOffset = "\(offset)"
        return self
    }

    /**
     Add an filter parameter to the query
     
     - Author:
     Craig Tweedy
     
     - parameters:
        - operator: The `MoltinFilterOperator` to use
        - key: The key for the filter
        - value: The value for the filter
     
     - returns:
     A instance of `MoltinRequest` which encapsulates the request.
     */
    public func filter(operator op: MoltinFilterOperator, key: String, value: String) -> Self {
        self.query.withFilter.append((op, key, value))
        return self
    }
}
