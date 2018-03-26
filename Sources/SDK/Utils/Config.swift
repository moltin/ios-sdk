//
//  Config.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

/// `MoltinConfig` holds information about the general configuration of the SDK, such as the client ID or the locale, for use during API calls.
public struct MoltinConfig {
    public var clientID: String
    public var scheme: String
    public var host: String
    public var version: String
    
    public var locale: Locale = Locale.current
    
    init(clientID: String, scheme: String, host: String, version: String) {
        self.clientID = clientID
        self.scheme = scheme
        self.host = host
        self.version = version
    }
    
    init(clientID: String, scheme: String, host: String, version: String, locale: Locale) {
        self.init(clientID: clientID, scheme: scheme, host: host, version: version)
        self.locale = locale
    }
    
    static func `default`(withClientID clientID: String) -> MoltinConfig {
        return MoltinConfig(
            clientID: clientID,
            scheme: "https",
            host: "api.moltin.com",
            version: "v2")
    }
    
    static func `default`(withClientID clientID: String, withLocale locale: Locale) -> MoltinConfig {
        return MoltinConfig(
            clientID: clientID,
            scheme: "https",
            host: "api.moltin.com",
            version: "v2",
            locale: locale)
    }
}

extension MoltinConfig: Equatable {}

public func ==(lhs: MoltinConfig, rhs: MoltinConfig) -> Bool {
    return lhs.clientID == rhs.clientID &&
        lhs.scheme == rhs.scheme &&
        lhs.host == rhs.host &&
        lhs.version == rhs.version &&
        lhs.locale == rhs.locale
}
