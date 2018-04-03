//
//  Error.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

/// `MoltinError` encapsultes various errors that the SDK can return, as well as returning additional information if there are errors such as decoding errors
public enum MoltinError: Error {
    /// Thrown if a request could not authenticate
    case couldNotAuthenticate
    /// Thrown if the response returned an unacceptable error
    case responseError(underlyingError: Error?)
    /// Thrown if the data could not be added to the request
    case couldNotSetData
    /// Thrown if the response data can not be parsed correctly. Encapsulates a `DecodingError` for more infromation.
    case couldNotParseData(underlyingError: DecodingError?)
    /// Thrown if the response does not have any data
    case couldNotFindData
    /// Thrown if the response cannot parse a `Date`
    case couldNotParseDate
    /// Thrown if the request is not formed correctly
    case unacceptableRequest
    /// Thrown if no data was returned from the API
    case noData
}

extension MoltinError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .couldNotParseData(let error):
            return error?.localizedDescription ?? "Could not parse data"
        case .couldNotAuthenticate:
            return "Could not authenticate"
        case .responseError(let error):
            return error?.localizedDescription ?? "Response did not succeed"
        case .couldNotFindData:
            return "Could not find any data"
        case .couldNotParseDate:
            return "Date could not be parsed"
        case .noData:
            return "No data found"
        case .unacceptableRequest:
            return "Could not compose request"
        case .couldNotSetData:
            return "Could not serialize data"
        }
    }
}
