//
//  URLSession.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {

    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        let dataTask: URLSessionDataTask = self.dataTask(with: urlRequest, completionHandler: completionHandler)
        return dataTask as URLSessionDataTaskProtocol
    }

}

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
