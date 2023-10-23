//
//  RaceDataMock.swift
//  EntainCodeChallengeTests
//
//  Created by Jason Leocata on 22/10/2023.
//

import Foundation

extension RaceData {
    static func mock(nextToGoIds: [String] = [],
                     raceSummaries: [String : RaceSummary] = [:]) -> RaceData {
        return RaceData(nextToGoIds: nextToGoIds,
                        raceSummaries: raceSummaries)
    }
}
