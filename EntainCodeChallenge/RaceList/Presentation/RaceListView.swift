//
//  RaceListView.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 20/10/2023.
//

import SwiftUI

struct RaceListView: View {
    
    // MARK: - Private Attributes
    
    @ObservedObject private var viewModel: RaceListViewModel
    
    // MARK: - Init
    
    init(viewModel: RaceListViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - UI
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            header
            list
        }
        // TODO: Add localizable
        .navigationTitle("EntainTechTask")
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    var header: some View {
        HStack {
            ForEach(RaceType.allCases, id: \.self) { raceType in
                Button {
                    viewModel.filterButtonTapped(type: raceType)
                } label: {
                    ZStack {
                        Circle()
                            .foregroundColor(viewModel.filterSelected(type: raceType)
                                             ? Color.accentColor
                                             : Color(AppConstants.Color.grey))
                        raceType.image
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.all, 4.0)
                            .foregroundColor(viewModel.filterSelected(type: raceType)
                                             ? .white
                                             : .primary)
                    }
                    .frame(maxWidth: 40.0, maxHeight: 40.0)
                }
            }
            Spacer()
        }
        .padding(.all, 16.0)
    }
    
    var list: some View {
        
        // TODO: Show Error or No Network View
        
        LazyVStack(alignment: .leading,
                   spacing: 0.0,
                   pinnedViews: [.sectionHeaders]) {
            Section {
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .padding(.all, 20.0)
                }
                
                ForEach(viewModel.filteredRaceCellViewModels, id: \.id) { raceCellViewModel in
                    RaceCellView(viewModel: raceCellViewModel)
                }
            } header: {
                // TODO: Add localizable
                let viewModel = RaceListHeaderViewModel(title: "NEXT RACES",
                                                        countdownProgress: viewModel.countdownProgress,
                                                        refreshTimeText: viewModel.refreshTimeText)
                RaceListHeaderView(viewModel: viewModel)
                
            } footer: {
                let viewModel = RaceListFooterViewModel(lastUpdateTimeText: viewModel.lastUpdateTimeText)
                RaceListFooterView(viewModel: viewModel)
            }
        }
    }
}

struct NextUpView_Previews: PreviewProvider {
    static var previews: some View {
        RaceListView(viewModel: RaceListViewModel())
    }
}
