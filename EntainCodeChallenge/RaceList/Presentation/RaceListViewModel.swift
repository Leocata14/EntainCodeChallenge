//
//  NextUpViewModel.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 20/10/2023.
//

import Foundation
import SwiftUI
import Combine

final class RaceListViewModel: ObservableObject {
    
    // MARK: - Public Attributes
    
    @Published var isLoading: Bool = false
    @Published var raceCellViewModels: [RaceCellViewModel] = []
    @Published var selectedFilters: Set<RaceType> = [.horse, .greyhound, .harness]
    @Published var refreshInSeconds: TimeInterval = AppConstants.Timer.automaticRefreshInSeconds
    @Published var countdownProgress = 0.0
    @Published var lastUpdate = Date.now
    
    var lastUpdateTimeText: String {
        // TODO: Add localizable
        return "Last Updated: \(dateFormatter.string(from: lastUpdate))"
    }
    
    var refreshTimeText: String {
        return "\(Int(refreshInSeconds))"
    }
    
    var filteredRaceCellViewModels: [RaceCellViewModel] {
        if !selectedFilters.isEmpty {
            return Array(raceCellViewModels
                .filter({ selectedFilters.contains($0.type) })
                .prefix(AppConstants.Race.raceMaxCount))
        } else {
            return Array(raceCellViewModels.prefix(AppConstants.Race.raceMaxCount))
        }
    }
    
    // MARK: - Private Attributes

    private var refreshTimer: AnyCancellable?
    private var countdownTimer: AnyCancellable?
    private let dateFormatter: DateFormatter = DateFormatter.make()
    
    var client: RaceClientType
    
    // MARK: - Init
    
    init(client: RaceClientType = RaceAPIClient()) {
        self.client = client
    }
    
    // MARK: - UI Lifecycle
    
    func onAppear() {
        load(isRefresh: false)
    }
    
    // MARK: - API
    
    private func load(isRefresh: Bool) {
        isLoading = isRefresh ? false : true
        
        Task {
            await loadData(isRefresh: isRefresh)
            startRefreshTimer()
            startCountdownTimer()
        }
    }
    
    private func loadData(isRefresh: Bool) async {
        do {
            let races = try await client.fetchRaces().values
                .sorted(by: { $0.advertisedStart.seconds < $1.advertisedStart.seconds })
                .filter({ ($0.advertisedStart.seconds - Int(Date.now.timeIntervalSince1970.rounded())) > AppConstants.Timer.maxTimeRemaining })

            let newRaces = races.filter { newRaceSummary in
                !self.raceCellViewModels.contains { raceCellViewModel in
                    return newRaceSummary.raceId == raceCellViewModel.id
                }
            }

            let newRaceCellViewModels = newRaces.map {
                let raceCellViewModel =  RaceCellViewModel(race: $0)
                raceCellViewModel.delegate = self
                 
                return raceCellViewModel
            }

            DispatchQueue.main.async {
                if isRefresh {
                    self.raceCellViewModels.append(contentsOf: newRaceCellViewModels)
                } else {
                    self.raceCellViewModels = newRaceCellViewModels
                }

                _ = self.raceCellViewModels.sorted(by: { $0.advertisedStartSeconds < $1.advertisedStartSeconds })

                self.lastUpdate = Date.now
            }
        } catch {
            // TODO: Display Error
            print("Error fetching data: \(error.localizedDescription)")
            // TODO: Error Reporting
        }
        
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
    
    func refreshData()  {
        load(isRefresh: true)
    }
    
    // MARK: - Filter
    
    func filterSelected(type: RaceType) -> Bool {
        return selectedFilters.contains(type)
    }
    
    func filterButtonTapped(type: RaceType) {
        
        guard selectedFilters.count != 1 else {
            resetFilters()
            return
        }
        
        if selectedFilters.contains(type) {
            selectedFilters.remove(type)
        } else {
            selectedFilters.insert(type)
        }
    }
    
    func resetFilters() {
        selectedFilters = Set(RaceType.allCases)
    }
    
    // MARK: - Timer
    
    private func startRefreshTimer() {
        refreshTimer = Timer.publish(every: AppConstants.Timer.automaticRefreshInSeconds, on: .main, in: .common).autoconnect()
            .sink { _ in
                self.refreshData()
            }
        
        DispatchQueue.main.async {
            self.refreshInSeconds = AppConstants.Timer.automaticRefreshInSeconds
        }
    }
    
    private func updateRemainingTime() {
        if refreshInSeconds > 0 {
            refreshInSeconds -= 1
        } else {
            refreshInSeconds = AppConstants.Timer.automaticRefreshInSeconds
        }
        
        countdownProgress = refreshInSeconds / AppConstants.Timer.automaticRefreshInSeconds
    }
    
    // MARK: - Countdown Timer
    
    private func startCountdownTimer() {
        countdownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            .sink { _ in
                self.updateRemainingTime()
            }
    }
}

extension RaceListViewModel: RaceCellViewModelDelegate {
    func removeRaceCellView(_ raceCellViewModel: RaceCellViewModel) {
        if let index = raceCellViewModels.firstIndex(where: { $0 === raceCellViewModel }) {
            raceCellViewModels.remove(at: index)
        }
    }
}
