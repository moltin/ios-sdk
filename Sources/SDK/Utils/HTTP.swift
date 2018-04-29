//
//  HTTP.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

/// Type alias which defines a common request pattern tuple
public typealias HTTPRequestHandler = (Data?, URLResponse?, Error?) -> Void
/// Type alias which defines the standard response for an endpoint which returns a list of data
public typealias CollectionRequestHandler<T: Codable> = (Result<PaginatedResponse<T>>) -> Void
/// Type alias which defines the standard response for an endpoint which returns a single item
public typealias ObjectRequestHandler<T: Codable> = (Result<T>) -> Void

class MoltinHTTP {

    let session: URLSessionProtocol
    let dataSerializer: DataSerializer

    init(withSession session: URLSessionProtocol,
         withSerializer serializer: DataSerializer = MoltinDataSerializer()) {
        self.session = session
        self.dataSerializer = serializer
    }

    func executeRequest(_ request: URLRequest?, completionHandler: @escaping HTTPRequestHandler) {
        guard let urlRequest = request else {
            completionHandler(nil, nil, MoltinError.unacceptableRequest)
            return
        }

        self.session.dataTask(with: urlRequest) { (data, response, error) in
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
            request.httpBody = try self.dataSerializer.serialize(data)
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

    func configureRequest(_ urlRequest: URLRequest, withToken token: String?, withConfig config: MoltinConfig?) -> URLRequest {
        var mutableRequest = urlRequest

        if let token = token {
            mutableRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        }
        mutableRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        mutableRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        mutableRequest.addValue("swift", forHTTPHeaderField: "X-MOLTIN-SDK-LANGUAGE")
        mutableRequest.addValue("3.0.7", forHTTPHeaderField: "X-MOLTIN-SDK-VERSION")

        if let config = config {
            mutableRequest.addValue(config.locale.identifier, forHTTPHeaderField: "X-MOLTIN-LOCALE")
            if let languageCode = config.locale.languageCode {
                mutableRequest.addValue(languageCode, forHTTPHeaderField: "X-MOLTIN-LANGUAGE")
            }

            if let currencyCode = config.locale.currencyCode {
                mutableRequest.addValue(currencyCode, forHTTPHeaderField: "X-MOLTIN-CURRENCY")
            }
        }

        return mutableRequest
    }
}
