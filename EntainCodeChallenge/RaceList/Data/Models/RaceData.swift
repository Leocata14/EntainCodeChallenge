//
//  RaceData.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 20/10/2023.
//

import Foundation

final class RaceData: Decodable {
    
    // MARK: - Enum
    
    enum CodingKeys: String, CodingKey {
        case nextToGoIds = "next_to_go_ids"
        case raceSummaries = "race_summaries"
    }
    
    // MARK: - Public Attributes
    
    let nextToGoIds: [String]
    let raceSummaries: [String : RaceSummary]
    
    // MARK: - Init
    
    init(nextToGoIds: [String],
         raceSummaries: [String : RaceSummary]) {
        self.nextToGoIds = nextToGoIds
        self.raceSummaries = raceSummaries
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        nextToGoIds = try container.decode([String].self, forKey: .nextToGoIds)
        raceSummaries = try container.decode([String: RaceSummary].self, forKey: .raceSummaries)
    }
}
