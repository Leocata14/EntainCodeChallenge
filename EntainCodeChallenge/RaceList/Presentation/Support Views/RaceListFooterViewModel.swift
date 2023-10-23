//
//  RaceListFooterViewModel.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 23/10/2023.
//

import Foundation

class RaceListFooterViewModel: ObservableObject {
    // MARK: - Public Attributes
    
    @Published var lastUpdateTimeText = ""
    
    // MARK: - Init
    
    init(lastUpdateTimeText: String) {
        self.lastUpdateTimeText = lastUpdateTimeText
    }
}
