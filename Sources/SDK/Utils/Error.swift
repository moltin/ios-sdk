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
    case couldNotParseData
    case unacceptableRequest
    case noData
    case referenceLost
}
