//
//  AppConstants.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 20/10/2023.
//

import Foundation
import SwiftUI

enum AppConstants {
    
    enum Color {
        static let charcoal: String = "charcoal"
        static let darkGrey: String = "darkGrey"
        static let grey: String = "grey"
    }
    
    enum Url {
        static let urlString: String = "https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=30"
    }
    
    enum Timer {
        static let maxTimeRemaining: Int = -60
        static let automaticRefreshInSeconds: TimeInterval = TimeInterval(60)
    }
    
    enum Race {
        static let raceMaxCount: Int = 5
    }
    
    enum Date {
        static let DateAndTimeFormat = "d MMM y HH:mm a"
    }
}
