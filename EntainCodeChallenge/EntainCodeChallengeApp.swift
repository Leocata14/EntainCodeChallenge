//
//  EntainCodeChallengeApp.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 20/10/2023.
//

import SwiftUI

@main
struct EntainCodeChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RaceListView(viewModel: RaceListViewModel())
            }
        }
    }
}
