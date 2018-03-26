//
//  Pagination.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

/// `PaginationResponse` wraps around a list endpoint response, to give context to the user about the pagination information
public class PaginatedResponse<T: Codable>: Codable {
    public typealias ContainedType = T
    
    public var data: ContainedType?
    public var links: [String: String?]?
    public var meta: PaginationMeta?
}

/// `PaginationMeta` gives information about the pagination details to the user, such as result information and page information
public class PaginationMeta: Codable {
    public let results: [String: Int]?
    public let page: [String: Int]?
}
