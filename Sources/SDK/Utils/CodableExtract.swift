//
//  CodableExtract.swift
//  moltin
//
//  Created by Craig Tweedy on 21/03/2018.
//

import Foundation

/// Container type alias for includes
public typealias IncludesContainer = [String: IncludesData]
/// Data schema type alias for includes
public typealias IncludesData = [[String: Any]]

extension Decodable {

    /// Faciliates the use of extracting a single object from `includes` based on `relationships`, and converting that object to type `T`, which must be `Codable`
    public func decodeSingle<T: Codable>(
        fromRelationships relationships: RelationshipSingle?,
        withIncludes includes: IncludesData? = []) throws -> T? {
        let data: T? = try self.extractObject(withKey: "id",
                                           withValue: relationships?.getId(),
                                           fromIncludes: includes)

        return data
    }

    /// Faciliates the use of extracting multiple objects from `includes` based on `relationships`, and converting those objects to type `T`, which must be `Codable`
    public func decodeMany<T: Codable>(
        fromRelationships relationships: RelationshipMany?,
        withIncludes includes: IncludesData? = []) throws -> [T]? {
        let data: [T]? = try self.extractArray(
            withKey: "id",
            withValues: relationships?.getIds(),
            fromIncludes: includes)

        return data
    }

    private func extractObject<T: Codable>(withKey key: String, withValue value: String?, fromIncludes includes: IncludesData? = []) throws -> T? {

        let foundItem = includes?.first { (obj) -> Bool in
            return obj[key] as? String == value
        }
        guard let item = foundItem else {
            return nil
        }
        let itemData = try JSONSerialization.data(withJSONObject: item, options: [])

        let decoder = JSONDecoder.dateFormattingDecoder()
        return try decoder.decode(T.self, from: itemData)
    }

    private func extractArray<T: Codable>(withKey key: String, withValues values: [String]? = [], fromIncludes includes: IncludesData? = []) throws -> [T]? {

        let items = includes?.filter { (obj) -> Bool in
            return values?.contains(obj[key] as? String ?? "") ?? false
        } ?? []
        let itemData = try JSONSerialization.data(withJSONObject: items, options: [])

        let decoder = JSONDecoder.dateFormattingDecoder()
        return try decoder.decode([T].self, from: itemData)
    }

}

extension JSONDecoder {
    /// Returns a default `JSONDecoder` which can decode ISO8601 dates with and without milliseconds
    static public func dateFormattingDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let dateString = try decoder.singleValueContainer().decode(String.self)
            if let date = DateFormatter.iso8601Full.date(from: dateString) {
                return date
            }

            if let date = DateFormatter.iso8601NoMilli.date(from: dateString) {
                return date
            }

            throw MoltinError.couldNotParseDate
        })
        return decoder
    }
}
