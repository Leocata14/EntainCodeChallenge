//
//  RaceListHeaderView.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 21/10/2023.
//

import SwiftUI

struct RaceListHeaderView: View {
    
    // MARK: - Private Attributes
    
    @ObservedObject private var viewModel: RaceListHeaderViewModel
    
    // MARK: - Init
    
    init(viewModel: RaceListHeaderViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - UI
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HStack {
                Image(systemName: "stopwatch.fill")
                
                //TODO: Add Localizable
                Text(viewModel.title)
                    .font(.caption)
                    .fontWeight(.bold)

                Spacer()
                
                VStack(alignment: .trailing, spacing: 5.0) {
                    ZStack {
                        Circle()
                            .stroke(Color.accentColor.opacity(0.5), lineWidth: 3.0)
                        
                        Circle()
                            .trim(from: 0, to: viewModel.countdownProgress)
                            .stroke(Color.accentColor, lineWidth: 3.0)
                            .rotationEffect(.degrees(-90.0))
                            .animation(.easeOut, value: viewModel.countdownProgress)
                        
                        Text(viewModel.refreshTimeText)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 30.0, height: 30.0)
                }
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background {
                Color(AppConstants.Color.charcoal)
            }
        }
    }
}

struct RaceListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        RaceListHeaderView(viewModel: RaceListHeaderViewModel(title: "NEXT RACES", countdownProgress: 0.0, refreshTimeText: "1"))
    }
}
