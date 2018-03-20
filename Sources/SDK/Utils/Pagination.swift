//
//  Pagination.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

public class PaginatedResponse<T: Codable>: Codable {
    public typealias ContainedType = T
    
    public var data: ContainedType?
    public let links: [String: String] = [:]
    public let meta: PaginationMeta = PaginationMeta()
}

public class PaginationMeta: Codable {
    public let results: [String: String] = [:]
    public let page: [String: String] = [:]
}
