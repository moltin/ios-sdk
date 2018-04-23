//
//  Query.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

/// `MoltinInclude` represents various resources which can be included into other API calls, such as including the collections assigned to products
/// This struct is for use in the `MoltinRequest.include(...)` method
public struct MoltinInclude: RawRepresentable, Equatable {

    public typealias RawValue = String

    public var rawValue: String

    /// Includes `File` objects
    public static let files  = MoltinInclude(rawValue: "files")
    /// Includes `Product` objects
    public static let products = MoltinInclude(rawValue: "products")
    /// Includes `Collection` objects
    public static let collections = MoltinInclude(rawValue: "collections")
    /// Includes `Brand` objects
    public static let brands = MoltinInclude(rawValue: "brands")
    /// Includes `Category` objects
    public static let categories = MoltinInclude(rawValue: "categories")
    /// Includes a `File` object representing the main image
    public static let mainImage = MoltinInclude(rawValue: "main_image")

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

}

/// `MoltinFilterOperator` represents various operations that can be applied to `MoltinRequest.filter(...)`
/// These parameters allow a user to filter resources.
public struct MoltinFilterOperator: RawRepresentable, Equatable {

    public typealias RawValue = String

    public var rawValue: String

    /// Represents an "equals" filter
    public static let equal                = MoltinFilterOperator(rawValue: "eq")
    /// Represents an "equals" filter
    public static let like                 = MoltinFilterOperator(rawValue: "like")
    ///Represents a "greater than" filter
    public static let greaterThan          = MoltinFilterOperator(rawValue: "gt")
    ///Represents a "greater than or equal to" filter
    public static let greaterThanOrEqual   = MoltinFilterOperator(rawValue: "ge")
    ///Represents a "less than" filter
    public static let lessThan             = MoltinFilterOperator(rawValue: "lt")
    ///Represents a "less than or equal to" filter
    public static let lessThanOrEqual      = MoltinFilterOperator(rawValue: "le")

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

}

/// `MoltinQuery` encapsulates all query parameters applied to a request, as well as converting these parameters to `[URLQueryItem]`
open class MoltinQuery {
    var withIncludes: [MoltinInclude]?
    var withSorting: String?
    var withLimit: String?
    var withOffset: String?
    var withFilter: [(MoltinFilterOperator, String, String)] = []

    func toURLQueryItems() -> [URLQueryItem] {
        var queryParams: [URLQueryItem] = []

        if let includes = self.withIncludes {
            queryParams.append(URLQueryItem(name: "include", value: includes.map { $0.rawValue }.joined(separator: ",")))
        }

        if let sort = self.withSorting {
            queryParams.append(URLQueryItem(name: "sort", value: sort))
        }

        if let limit = self.withLimit {
            queryParams.append(URLQueryItem(name: "page[limit]", value: limit))
        }

        if let offset = self.withOffset {
            queryParams.append(URLQueryItem(name: "page[offset]", value: offset))
        }

        if self.withFilter.count > 0 {
            let filterString = self.withFilter.map { (op, key, value) -> String in
                return "\(op.rawValue)(\(key), \(value))"
            }.joined(separator: ":")
            queryParams.append(URLQueryItem(name: "filter", value: filterString))
        }

        return queryParams
    }
}
