//
//  HTTP.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

public typealias HTTPRequestHandler = (Data?, URLResponse?) -> ()
public typealias CollectionRequestHandler<T: Codable> = (Result<PaginatedResponse<T>>) -> ()
public typealias ObjectRequestHandler<T: Codable> = (Result<T>) -> ()

class MoltinHTTP {
    
    func executeRequest(_ request: URLRequest, completionHandler: @escaping HTTPRequestHandler) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completionHandler(data, response)
        }.resume()
    }
    
    func buildURLRequest(withConfiguration configuration: MoltinConfig,
                         withPath path: String,
                         withQueryParameters queryParameters: [URLQueryItem]) throws -> URLRequest {
        guard let url = self.buildURL(
            withConfiguration: configuration,
            withEndpoint: path,
            withQueryParameters: queryParameters
        ) else {
            throw MoltinError.unacceptableRequest
        }
        
        return URLRequest(url: url)
    }
    
    private func buildURL(withConfiguration configuration: MoltinConfig,
                          withEndpoint endpoint: String,
                          withQueryParameters queryParams: [URLQueryItem]) -> URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = configuration.scheme
        urlComponents.host = configuration.host
        urlComponents.path = "/\(configuration.version)\(endpoint)"
        urlComponents.queryItems = queryParams
        
        return urlComponents.url
    }
}
