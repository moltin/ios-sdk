//
//  Config.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

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
