//
//  Error.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

/// `MoltinError` encapsultes various errors that the SDK can return, as well as returning additional information if there are errors such as decoding errors
public enum MoltinError : Error {
    case couldNotAuthenticate
    case couldNotSetData
    case couldNotParseData(underlyingError: DecodingError?)
    case couldNotFindDataKey
    case couldNotParseDate
    case unacceptableRequest
    case noData
    
    public var localizedDescription: String {
        switch self {
        case .couldNotParseData(let error):
            return error?.localizedDescription ?? "Could not parse data"
        case .couldNotAuthenticate:
            return "Could not authenticate"
        case .couldNotFindDataKey:
            return "Could not find any key with the name data"
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
