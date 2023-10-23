//
//  AdvertisedStart.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 20/10/2023.
//

import Foundation

final class AdvertisedStart: Decodable {
    
    // MARK: - Enum
    
    enum CodingKeys: String, CodingKey {
        case seconds
    }
    
    // MARK: - Public Attributes
    
    let seconds: Int
    
    // MARK: - Init
    
    init(seconds: Int) {
        self.seconds = seconds
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        seconds = try container.decode(Int.self, forKey: .seconds)
    }
}
