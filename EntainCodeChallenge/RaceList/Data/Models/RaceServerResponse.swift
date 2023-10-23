//
//  RaceServerResponse.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 20/10/2023.
//

import Foundation

final class RaceServerResponse: Decodable {
    
    // MARK: - Enum
    
    enum CodingKeys: String, CodingKey {
        case status, data, message
    }
    
    // MARK: - Public Attributes
    
    let status: Int
    let data: RaceData
    let message: String
    
    // MARK: - Init
    
    init(status: Int,
         data: RaceData,
         message: String) {
        self.status = status
        self.data = data
        self.message = message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        status = try container.decode(Int.self, forKey: .status)
        data = try container.decode(RaceData.self, forKey: .data)
        message = try container.decode(String.self, forKey: .message)
    }
}
