//
//  Pagination.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

/// `PaginationResponse` wraps around a list endpoint response, to give context to the user about the pagination information
open class PaginatedResponse<T: Codable>: Codable {
    /// Holds the real type of T ([Product] / Product / Brand / Collection) etc
    public typealias ContainedType = T

    /// The data returned for this response
    public var data: ContainedType?
    /// The external links for this response
    public var links: [String: String?]?
    /// The meta information for this response
    public var meta: PaginationMeta?

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }

    @discardableResult public func next(withConfig config: MoltinConfig, withCompletion completionHandler: @escaping (Result<PaginatedResponse<T>>) -> Void) -> MoltinRequest? {
        guard let page = self.links?["next"] as? String,
            let url = URL(string: page) else {
            completionHandler(.failure(error: MoltinError.noPageAvailable))
            return nil
        }

        let request = MoltinRequest(withConfiguration: config)
        return request.paginationRequest(withURL: url, completionHandler: completionHandler)
    }

    @discardableResult public func previous(withConfig config: MoltinConfig, withCompletion completionHandler: @escaping (Result<PaginatedResponse<T>>) -> Void) -> MoltinRequest? {
        guard let page = self.links?["prev"] as? String,
            let url = URL(string: page) else {
                completionHandler(.failure(error: MoltinError.noPageAvailable))
                return nil
        }

        let request = MoltinRequest(withConfiguration: config)
        return request.paginationRequest(withURL: url, completionHandler: completionHandler)
    }

    @discardableResult public func first(withConfig config: MoltinConfig, withCompletion completionHandler: @escaping (Result<PaginatedResponse<T>>) -> Void) -> MoltinRequest? {
        guard let page = self.links?["first"] as? String,
            let url = URL(string: page) else {
                completionHandler(.failure(error: MoltinError.noPageAvailable))
                return nil
        }

        let request = MoltinRequest(withConfiguration: config)
        return request.paginationRequest(withURL: url, completionHandler: completionHandler)
    }

    @discardableResult public func last(withConfig config: MoltinConfig, withCompletion completionHandler: @escaping (Result<PaginatedResponse<T>>) -> Void) -> MoltinRequest? {
        guard let page = self.links?["last"] as? String,
            let url = URL(string: page) else {
                completionHandler(.failure(error: MoltinError.noPageAvailable))
                return nil
        }

        let request = MoltinRequest(withConfiguration: config)
        return request.paginationRequest(withURL: url, completionHandler: completionHandler)
    }
}

/// `PaginationMeta` gives information about the pagination details to the user, such as result information and page information
open class PaginationMeta: Codable {
    /// The results information for this paginated response
    public let results: [String: Int]?
    /// The page information for this response
    public let page: [String: Int]?
}
