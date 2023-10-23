//
//  RaceType.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 20/10/2023.
//

import Foundation
import SwiftUI

enum RaceType: String,
               CaseIterable {
    case horse = "4a2788f8-e825-4d36-9894-efd4baf1cfae"
    case greyhound = "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
    case harness = "161d9be2-e909-4326-8c2c-35ed71fb460b"
    
    var title: String {
        switch self {
        case .horse: return "Horse Racing"
        case .greyhound: return "Greyhound Racing"
        case .harness: return "Harness Racing"
        }
    }
    
    var image: Image {
        switch self {
        case .greyhound: return Image("greyhound")
        case .harness: return Image("harness")
        case .horse: return Image("horse")
        }
    }
}
