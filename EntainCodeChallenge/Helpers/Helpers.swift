//
//  Helpers.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 20/10/2023.
//

import Foundation

extension Int {
    func secondsToHoursMinutesSeconds() -> (hours: Int, minutes: Int, seconds: Int) {
        return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }
}

extension DateFormatter {
    static func make(format: String = AppConstants.Date.DateAndTimeFormat) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}
