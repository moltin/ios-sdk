//
//  Config.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

/// `MoltinConfig` holds information about the general configuration of the SDK, such as the client ID or the locale, for use during API calls.
public struct MoltinConfig {
    /// The moltin client ID to use to connect to a store
    public var clientID: String
    /// HTTP or HTTPS
    public var scheme: String
    /// The URL host of the API
    public var host: String
    /// The version of the API
    public var version: String

    /// The locale to use for langauges and currencies
    public var locale: Locale = Locale.current

    /// Initialise the config with a clientID, scheme, host, and version
    public init(clientID: String, scheme: String, host: String, version: String) {
        self.clientID = clientID
        self.scheme = scheme
        self.host = host
        self.version = version
    }

    /// Initialise the config with a clientID, scheme, host, version, and locale
    public init(clientID: String, scheme: String, host: String, version: String, locale: Locale) {
        self.init(clientID: clientID, scheme: scheme, host: host, version: version)
        self.locale = locale
    }

    /// Returns a default config set up with a clientID
    static public func `default`(withClientID clientID: String) -> MoltinConfig {
        return MoltinConfig(
            clientID: clientID,
            scheme: "https",
            host: "api.moltin.com",
            version: "v2")
    }

    /// Returns a default config set up with a clientID and a locale
    static public func `default`(withClientID clientID: String, withLocale locale: Locale) -> MoltinConfig {
        return MoltinConfig(
            clientID: clientID,
            scheme: "https",
            host: "api.moltin.com",
            version: "v2",
            locale: locale)
    }
}

extension MoltinConfig: Equatable {}

/// Validates that two `MoltinConfig` objects and equal
public func == (lhs: MoltinConfig, rhs: MoltinConfig) -> Bool {
    return lhs.clientID == rhs.clientID &&
        lhs.scheme == rhs.scheme &&
        lhs.host == rhs.host &&
        lhs.version == rhs.version &&
        lhs.locale == rhs.locale
}
