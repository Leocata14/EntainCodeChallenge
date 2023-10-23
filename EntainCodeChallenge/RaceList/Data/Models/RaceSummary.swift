//
//  RaceSummary.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 20/10/2023.
//

import Foundation

final class RaceSummary: Decodable {
    
    // MARK: - Enum
    
    enum CodingKeys: String,
                     CodingKey {
        case raceId = "race_id"
        case raceName = "race_name"
        case raceNumber = "race_number"
        case meetingId = "meeting_id"
        case meetingName = "meeting_name"
        case categoryId = "category_id"
        case advertisedStart = "advertised_start"
        case venueId = "venue_id"
        case venueName = "venue_name"
        case venueState = "venue_state"
        case venueCountry = "venue_country"
        case raceType
    }
    
    // MARK: - Public Atrributes
    
    let raceId: String
    let raceName: String
    let raceNumber: Int
    let meetingId: String
    let meetingName: String
    let categoryId: String
    let advertisedStart: AdvertisedStart
    let venueId: String
    let venueName: String
    let venueState: String
    let venueCountry: String
    let raceType: RaceType
    let raceDate: Date
    
    // MARK: - Init
    
    init(raceId: String,
         raceName: String,
         raceNumber: Int,
         meetingId: String,
         meetingName: String,
         categoryId: String,
         advertisedStart: AdvertisedStart,
         venueId: String,
         venueName: String,
         venueState: String,
         venueCountry: String,
         raceType: RaceType,
         raceDate: Date) {
        self.raceId = raceId
        self.raceName = raceName
        self.raceNumber = raceNumber
        self.meetingId = meetingId
        self.meetingName = meetingName
        self.categoryId = categoryId
        self.advertisedStart = advertisedStart
        self.venueId = venueId
        self.venueName = venueName
        self.venueState = venueState
        self.venueCountry = venueCountry
        self.raceType = raceType
        self.raceDate = raceDate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        raceId = try container.decode(String.self, forKey: .raceId)
        raceName = try container.decode(String.self, forKey: .raceName)
        raceNumber = try container.decode(Int.self, forKey: .raceNumber)
        meetingId = try container.decode(String.self, forKey: .meetingId)
        meetingName = try container.decode(String.self, forKey: .meetingName)
        categoryId = try container.decode(String.self, forKey: .categoryId)
        advertisedStart = try container.decode(AdvertisedStart.self, forKey: .advertisedStart)
        venueId = try container.decode(String.self, forKey: .venueId)
        venueName = try container.decode(String.self, forKey: .venueName)
        venueState = try container.decode(String.self, forKey: .venueState)
        venueCountry = try container.decode(String.self, forKey: .venueCountry)
        raceDate = Date(timeIntervalSince1970: TimeInterval(advertisedStart.seconds))
        
        let raceTypeRawValue = try container.decode(String.self, forKey: CodingKeys.categoryId)
        if let raceType = RaceType(rawValue: raceTypeRawValue) {
            self.raceType = raceType
        } else {
            throw DecodingError.dataCorruptedError(forKey: .raceType,
                                                   in: container,
                                                   debugDescription: "Cannot decode `RaceType`.")
        }
    }
}
