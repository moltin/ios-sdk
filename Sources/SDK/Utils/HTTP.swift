//
//  HTTP.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

public typealias HTTPRequestHandler = (Data?, URLResponse?, Error?) -> ()
public typealias CollectionRequestHandler<T: Codable> = (Result<PaginatedResponse<T>>) -> ()
public typealias ObjectRequestHandler<T: Codable> = (Result<T>) -> ()

class MoltinHTTP {
    
    let session: URLSessionProtocol
    
    init(withSession session: URLSessionProtocol) {
        self.session = session
    }
    
    func executeRequest(_ request: URLRequest, completionHandler: @escaping HTTPRequestHandler) {        
        self.session.dataTask(with: request) { (data, response, error) in
            completionHandler(data, response, error)
        }.resume()
    }
    
    func buildURLRequest(withConfiguration configuration: MoltinConfig,
                         withPath path: String,
                         withQueryParameters queryParameters: [URLQueryItem],
                         withMethod method: HTTPMethod = .GET,
                         withData data: [String: Any]? = nil,
                         includeVersion: Bool = true) throws -> URLRequest {
        guard let url = self.buildURL(
            withConfiguration: configuration,
            withEndpoint: path,
            withQueryParameters: queryParameters,
            includeVersion: includeVersion
        ) else {
            throw MoltinError.unacceptableRequest
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.description
        
        if let data = data {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: data, options: [])
            } catch {
                throw MoltinError.couldNotSetData
            }
        }
        
        return request
    }
    
    func buildURL(withConfiguration configuration: MoltinConfig,
                          withEndpoint endpoint: String,
                          withQueryParameters queryParams: [URLQueryItem],
                          includeVersion: Bool = true) -> URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = configuration.scheme
        urlComponents.host = configuration.host
        if includeVersion {
            urlComponents.path = "/\(configuration.version)\(endpoint)"
        } else {
            urlComponents.path = "\(endpoint)"
        }
        
        if queryParams.count > 0 {
            urlComponents.queryItems = queryParams
        }
        
        return urlComponents.url
    }
    
    func configureRequest(_ urlRequest: URLRequest, withAuth auth: MoltinAuth) -> URLRequest {
        var mutableRequest = urlRequest
        
        mutableRequest.addValue("Bearer " + (auth.token ?? ""), forHTTPHeaderField: "Authorization")
        mutableRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        mutableRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        mutableRequest.addValue(auth.config.locale.languageCode ?? "", forHTTPHeaderField: "X-MOLTIN-LANGUAGE")
        mutableRequest.addValue(auth.config.locale.identifier, forHTTPHeaderField: "X-MOLTIN-LOCALE")
        mutableRequest.addValue(auth.config.locale.currencyCode ?? "", forHTTPHeaderField: "X-MOLTIN-CURRENCY")
        
        
        return mutableRequest
    }
}
