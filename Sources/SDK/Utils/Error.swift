//
//  Error.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

public enum MoltinError : Error {
    case couldNotAuthenticate
    case couldNotSetData
    case couldNotParseData(underlyingError: DecodingError?)
    case couldNotFindDataKey
    case unacceptableRequest
    case noData
}
