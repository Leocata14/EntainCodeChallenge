//
//  RaceCellView.swift
//  EntainCodeChallenge
//
//  Created by Jason Leocata on 20/10/2023.
//

import SwiftUI

struct RaceCellView: View {
    
    // MARK: - Public Attributes
    
    @ObservedObject var viewModel: RaceCellViewModel
    
    // MARK: - Init
    
    init(viewModel: RaceCellViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - UI
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack(spacing: 0.0) {
                
                viewModel.type.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30.0, height: 30.0)
                    .padding(.trailing, 12.0)
                
                Text(viewModel.title)
                    .foregroundColor(Color.primary)
                
                Spacer()
                
                Text(viewModel.startDateText)
                    .font(.caption)
                    .fontWeight(.bold)
                
            }
            .padding()
            
            Divider()
        }
        .background(content: {
            Color(AppConstants.Color.grey)
        })
        .onAppear {
            viewModel.onAppear()
        }
    }
}
