//
//  RaceListFooterView.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 23/10/2023.
//

import SwiftUI

struct RaceListFooterView: View {

    // MARK: - Private Attributes
    
    @ObservedObject private var viewModel: RaceListFooterViewModel
    
    // MARK: - Init
    
    init(viewModel: RaceListFooterViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - UI
    
    var body: some View {
        HStack {
            Text(viewModel.lastUpdateTimeText)
                .font(.footnote)
                .fontWeight(.thin)
                .italic()
            Spacer()
        }
        .padding(.all, 16.0)
        .background {
            Color(AppConstants.Color.grey)
        }
    }
}

struct RaceListFooterView_Previews: PreviewProvider {
    static var previews: some View {
        RaceListFooterView(viewModel: RaceListFooterViewModel(lastUpdateTimeText: "Last Updated:"))
    }
}
