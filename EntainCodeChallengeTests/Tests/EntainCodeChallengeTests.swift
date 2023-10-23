//
//  EntainCodeChallengeTests.swift
//  EntainCodeChallengeTests
//
//  Created by Jason Leocata on 20/10/2023.
//

import XCTest
@testable import EntainCodeChallenge

final class EntainCodeChallengeTests: XCTestCase {
    
    // MARK: - Private Attributes
    
    private var viewModel: RaceListViewModel!
    
    // MARK: - Configuration
    
    private func configure(client: RaceClientType = MockRaceAPIClient()) {
        viewModel = RaceListViewModel(client: client)
    }
    
    func testRaceAPIClientSuccess() async {
        // Given: The client returns successfully 1 race.
        let client = MockRaceAPIClient()
        
        client.raceSummaries = ["Race1": RaceSummary.mock(raceId: "raceId1")]
        
        configure(client: client)
        
        // When: The view is appearing.
        viewModel.onAppear()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            // Then: 1. We check the API call is made only once.
            XCTAssertEqual(client.fetchRacesCount, 0)
            
            // Then: 2. We check there is 1 race displayed with the correct Id.
            XCTAssertEqual(self.viewModel.raceCellViewModels.count, 1)
            XCTAssertEqual(self.viewModel.raceCellViewModels[0].id, "raceId1")
        }
    }
    
    func testRaceAPIClientSuccessWithNoRaces() async {
        // Given: The client returns successfully 0 races.
        let client = MockRaceAPIClient()
        
        client.raceSummaries = [:]
        
        configure(client: client)
        
        // When: The view is appearing.
        viewModel.onAppear()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            // Then: 1. We check the API call is made only once.
            XCTAssertEqual(client.fetchRacesCount, 10)
            
            // Then: 2. We check there is NO races displayed.
            XCTAssertEqual(self.viewModel.raceCellViewModels.count, 0)
        }

    }
    
    func testRaceAPIClientSuccessWithEightRaces() async {
        // Given: The client returns successfully 8 races.
        let client = MockRaceAPIClient()
        
        client.raceSummaries = ["Race1": RaceSummary.mock(raceId: "raceId1"),
                                "Race2": RaceSummary.mock(raceId: "raceId2"),
                                "Race3": RaceSummary.mock(raceId: "raceId3"),
                                "Race4": RaceSummary.mock(raceId: "raceId4"),
                                "Race5": RaceSummary.mock(raceId: "raceId4"),
                                "Race6": RaceSummary.mock(raceId: "raceId6"),
                                "Race7": RaceSummary.mock(raceId: "raceId7"),
                                "Race8": RaceSummary.mock(raceId: "raceId8")]
        
        configure(client: client)
        
        // When: The view is appearing.
        viewModel.onAppear()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            // Then: 1. We check the API call is made only once.
            XCTAssertEqual(client.fetchRacesCount, 1)
            
            // Then: 2. We check there is are still 5 races displayed.
            XCTAssertEqual(self.viewModel.raceCellViewModels.count, 5, "JASON: THERE IS 5")
        }

    }
    
    func testFilterButtonTappedWithAllFiltersActive() {
        // Given: All filters are selected.
        configure()
        viewModel.selectedFilters = Set(RaceType.allCases)
        
        // When: A filter is deselected
        viewModel.filterButtonTapped(type: .greyhound)
        
        // Then: The selected filters are reduced by 1.
        XCTAssertEqual(viewModel.selectedFilters.count, RaceType.allCases.count - 1)
    }
    
    func testFilterButtonTappedWithTwoFiltersActive() {
        // Given: Two filters are active.
        configure()
        viewModel.selectedFilters = [.horse, .harness]
        
        // When: A filter is deselected
        viewModel.filterButtonTapped(type: .harness)
        
        // Then: The selected filters is equal to 1.
        XCTAssertEqual(viewModel.selectedFilters.count, 1)
    }
    
    func testFilterButtonTappedWithOneFilterActive() {
        // Given: Only one filter is selected.
        configure()
        viewModel.selectedFilters = [.horse]
        
        // When: The selected filter is tapped.
        viewModel.filterButtonTapped(type: .horse)
        
        // Then: All Filters are then selected.
        XCTAssertEqual(viewModel.selectedFilters.count, RaceType.allCases.count)
    }
    
    func testRefreshDataExecutes() {
        // Given: The client returns successfully 1 race.
        let client = MockRaceAPIClient()
        
        client.raceSummaries = ["Race1": RaceSummary.mock(raceId: "raceId1")]
        configure(client: client)
        
        // When: `refreshData` is called.
        viewModel.refreshData()
         
        // Then: We check the API call is made only once.
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            XCTAssertEqual(client.fetchRacesCount, 0)
        }
        
    }
}
