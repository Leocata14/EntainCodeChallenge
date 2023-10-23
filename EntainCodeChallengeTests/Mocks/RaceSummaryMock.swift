//
//  RaceSummaryMock.swift
//  EntainCodeChallengeTests
//
//  Created by Jason Leocata on 22/10/2023.
//

import Foundation

extension RaceSummary {
    static func mock(raceId: String = "",
                     raceName: String = "",
                     raceNumber: Int = 0,
                     meetingId: String = "",
                     meetingName: String = "",
                     categoryId: String = "",
                     advertisedStart: AdvertisedStart = AdvertisedStart.mock(),
                     venueId: String = "",
                     venueName: String = "",
                     venueState: String = "",
                     venueCountry: String = "",
                     raceType: RaceType = .greyhound,
                     raceDate: Date = Date()) -> RaceSummary {
            return RaceSummary(raceId: raceId,
                               raceName: raceName,
                               raceNumber: raceNumber,
                               meetingId: meetingId,
                               meetingName: meetingName,
                               categoryId: categoryId,
                               advertisedStart: AdvertisedStart(seconds: 1634908800),
                               venueId: venueId,
                               venueName: venueName,
                               venueState: venueState,
                               venueCountry: venueCountry,
                               raceType: raceType,
                               raceDate: raceDate)
        }
}
