//
//  RaceServerResponseMock.swift
//  EntainCodeChallengeTests
//
//  Created by Jason Leocata on 22/10/2023.
//

import Foundation

extension RaceServerResponse {
    static func mock(status: Int = 0,
                     data: RaceData = RaceData.mock(),
                     message: String = "") -> RaceServerResponse {
        return RaceServerResponse(status: status,
                                  data: data,
                                  message: message)
    }
}
