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
    public var links: PaginationLink?
    public var meta: PaginationMeta?
}

public class PaginationLink: Codable {
    
}

public class PaginationMeta: Codable {
    
}
