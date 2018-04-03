//
//  DateFormatter.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 20/03/2018.
//

import Foundation

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        return formatter
    }()

    static let iso8601NoMilli: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        return formatter
    }()
}
