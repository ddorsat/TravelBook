//
//  PopularView.swift
//  TravelBook
//
//  Created by ddorsat on 05.01.2026.
//

import SwiftUI

struct PopularView: View {
    let cells: [CellModel]
    let onTapHandler: (CellModel) -> Void
    
    var body: some View {
        ZStack {
            Components.backgroundColor(onlyBottom: true)
            
            ScrollView {
                CellFeedView(cell: cells) { cell in
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
    PopularView(cells: [CellModel.mock, CellModel.mock]) { _ in
        
    }
}
