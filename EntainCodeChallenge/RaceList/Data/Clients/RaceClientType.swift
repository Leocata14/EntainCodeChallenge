//
//  RaceClientType.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 21/10/2023.
//

import Foundation

protocol RaceClientType {
    func fetchRaces() async throws -> [String: RaceSummary]
}
