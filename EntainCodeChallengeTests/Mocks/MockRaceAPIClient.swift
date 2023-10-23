//
//  MockRaceAPIClient.swift
//  EntainCodeChallengeTests
//
//  Created by Jason Leocata on 22/10/2023.
//

import Foundation

class MockRaceAPIClient: RaceClientType {
    
    var raceSummaries: [String: RaceSummary]?
    var error: Error?
    var fetchRacesCount: Int = 0

    func fetchRaces() async throws -> [String: RaceSummary] {
        fetchRacesCount += 1
        
        if let raceSummaries = raceSummaries {
            return raceSummaries
        } else if let error = error {
            throw error
        }
        
        fatalError("Mock API Client not configured properly.")
    }
}
