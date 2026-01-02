//
//  PopularView.swift
//  TravelBook
//
//  Created by ddorsat on 05.01.2026.
//

import SwiftUI

struct PopularView: View {
    let cell: CellModel
    let onTapHandler: (CellModel) -> Void
    
    var body: some View {
        ZStack {
            Components.backgroundColor(onlyBottom: true)
            
            ScrollView {
                CellFeedView(cell: cell) { cell in
                    onTapHandler(cell)
                }
            }
        }
        .navigationTitle("Популярное")
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    PopularView(cell: .mock) { _ in
        
    }
}
