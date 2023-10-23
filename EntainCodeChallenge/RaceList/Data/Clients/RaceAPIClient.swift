//
//  RaceAPIClient.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 20/10/2023.
//

import Foundation

class RaceAPIClient: RaceClientType {
    func fetchRaces() async throws -> [String: RaceSummary] {
        guard let url = URL(string: AppConstants.Url.urlString) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(RaceServerResponse.self, from: data)
            return response.data.raceSummaries
        } catch {
            throw error
        }
    }
}
