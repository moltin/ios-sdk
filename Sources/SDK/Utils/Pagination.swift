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
}

/// `PaginationMeta` gives information about the pagination details to the user, such as result information and page information
open class PaginationMeta: Codable {
    /// The results information for this paginated response
    public let results: [String: Int]?
    /// The page information for this response
    public let page: [String: Int]?

    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1 broke Codable synthesized inits")
    }
}
