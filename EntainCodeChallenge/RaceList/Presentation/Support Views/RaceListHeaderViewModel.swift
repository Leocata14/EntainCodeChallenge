//
//  RaceListHeaderViewModel.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 21/10/2023.
//

import Foundation

class RaceListHeaderViewModel: ObservableObject {
    
    // MARK: - Public Attributes
    
    let title: String
    let refreshTimeText: String
    @Published var countdownProgress = 0.0
    
    // MARK: - Init
    
    init(title: String, countdownProgress: Double, refreshTimeText: String) {
        self.title = title
        self.countdownProgress = countdownProgress
        self.refreshTimeText = refreshTimeText
    }
    
}
