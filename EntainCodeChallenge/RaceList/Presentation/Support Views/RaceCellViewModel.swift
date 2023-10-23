//
//  RaceCellViewModel.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 20/10/2023.
//

import Foundation
import SwiftUI
import Combine

final class RaceCellViewModel: ObservableObject {
    
    // MARK: - Public Attributes
    
    let id: String
    let title: String
    let type: RaceType
    let advertisedStartSeconds: Int
    
    @Published var startDateText: String = ""
    
    var delegate: RaceCellViewModelDelegate?
    
    // MARK: - Private Attributes

    private var timer: AnyCancellable?
    
    // MARK: - Init
    
    init(id: String,
         title: String,
         type: RaceType,
         advertisedStartSeconds: Int) {
        self.id = id
        self.title = title
        self.type = type
        self.advertisedStartSeconds = advertisedStartSeconds
    }
    
    convenience init(race: RaceSummary) {
        let title = "\(race.meetingName) - R\(race.raceNumber)"

        self.init(id: race.raceId,
                  title: title,
                  type: race.raceType,
                  advertisedStartSeconds: race.advertisedStart.seconds)
    }
    
    // MARK: - UI Lifecycle
    
    func onAppear() {
        startTimer()
        
        setupTimeUI(timeRemainingInSeconds: advertisedStartSeconds - Int(Date.now.timeIntervalSince1970.rounded()))
    }
    
    // MARK: - UI
    
    // TODO: Move to helper file with Extension String
    
    func setupTimeUI(timeRemainingInSeconds: Int) {
        // Convert Time Remaining to Hours, Minutes and Seconds
        // Using abs to return a postive Int
        let (hours, minutes, seconds) = abs(timeRemainingInSeconds).secondsToHoursMinutesSeconds()
            switch (timeRemainingInSeconds, hours, minutes, seconds) {
                
            case (_, let h, _, _) where h >= 1:
                startDateText = "\(hours)hrs \(minutes)m"
            case (_, _, let m, _) where m >= 5:
                startDateText = "\(minutes)m"
            case (let t, _, let m, let s) where t > 0 && m >= 1:
                startDateText = "\(minutes)m \(s)s"
            case (let t, _, let m, let s) where t > 0 && m == 0:
                startDateText = "\(s)s"
            case (let t, _, let m, let s) where t < 0 && m == 0:
                startDateText = "-\(s)s"
            case (let t, _, let m, let s) where t < 0 && m >= 1:
                startDateText = "-\(minutes)m \(s)s"
            default:
                startDateText = "\(minutes)m"
            }
    }
    
    // MARK: - Timer
    
    func startTimer() {
        timer = Timer
            .publish(every: 1, on: .main, in: .common).autoconnect()
            .sink { _ in
                let timeRemainingInSeconds = self.advertisedStartSeconds - Int(Date.now.timeIntervalSince1970.rounded())
                
                // When the time remaining is less than the max time remaining (e.g 1 minute), remove the cell
                // Otherwise update the time remaining for the cell
                if timeRemainingInSeconds < AppConstants.Timer.maxTimeRemaining {
                    self.removeCell()
                } else {
                    self.setupTimeUI(timeRemainingInSeconds: timeRemainingInSeconds)
                }
            }
    }
    
    // MARK: - Remove Cell
    
    func removeCell() {
        timer?.cancel()
        withAnimation {
            delegate?.removeRaceCellView(self)
        }
    }
}

protocol RaceCellViewModelDelegate {
    func removeRaceCellView(_ raceCellViewModel: RaceCellViewModel)
}
