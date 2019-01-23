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

    /**
     Get the next page for this response
     
     - Author:
     Craig Tweedy
     
     - parameters:
         - withConfig: The moltin config to use
         - withCompletion: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func next(withConfig config: MoltinConfig, withCompletion completionHandler: @escaping (Result<PaginatedResponse<T>>) -> Void) -> MoltinRequest? {
        guard let page = self.links?["next"] as? String,
            let url = URL(string: page) else {
            completionHandler(.failure(error: MoltinError.noPageAvailable))
            return nil
        }

        let request = MoltinRequest(withConfiguration: config)
        return request.paginationRequest(withURL: url, completionHandler: completionHandler)
    }

    /**
     Get the previous page for this response
     
     - Author:
        Craig Tweedy
     
     - parameters:
        - withConfig: The moltin config to use
        - withCompletion: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func previous(withConfig config: MoltinConfig, withCompletion completionHandler: @escaping (Result<PaginatedResponse<T>>) -> Void) -> MoltinRequest? {
        guard let page = self.links?["prev"] as? String,
            let url = URL(string: page) else {
                completionHandler(.failure(error: MoltinError.noPageAvailable))
                return nil
        }

        let request = MoltinRequest(withConfiguration: config)
        return request.paginationRequest(withURL: url, completionHandler: completionHandler)
    }

    /**
     Get the first page for this response
     
     - Author:
     Craig Tweedy
     
     - parameters:
        - withConfig: The moltin config to use
        - withCompletion: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func first(withConfig config: MoltinConfig, withCompletion completionHandler: @escaping (Result<PaginatedResponse<T>>) -> Void) -> MoltinRequest? {
        guard let page = self.links?["first"] as? String,
            let url = URL(string: page) else {
                completionHandler(.failure(error: MoltinError.noPageAvailable))
                return nil
        }

        let request = MoltinRequest(withConfiguration: config)
        return request.paginationRequest(withURL: url, completionHandler: completionHandler)
    }

    /**
     Get the last page for this response
     
     - Author:
     Craig Tweedy
     
     - parameters:
        - withConfig: The moltin config to use
        - withCompletion: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
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
