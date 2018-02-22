//
//  Config.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

public struct MoltinConfig {
    public var scheme: String
    public var host: String
    public var version: String
    
    public var locale: Locale = Locale.current
    
    init(scheme: String, host: String, version: String) {
        self.scheme = scheme
        self.host = host
        self.version = version
    }
    
    init(scheme: String, host: String, version: String, locale: Locale) {
        self.init(scheme: scheme, host: host, version: version)
        self.locale = locale
    }
    
    static func `default`() -> MoltinConfig {
        return MoltinConfig(
            scheme: "https",
            host: "api.moltin.com",
            version: "v2")
    }
}
