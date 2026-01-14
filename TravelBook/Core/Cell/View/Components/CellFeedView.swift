//
//  CellFeedView.swift
//  TravelBook
//
//  Created by ddorsat on 05.01.2026.
//

import SwiftUI

struct CellFeedView: View {
    let cells: [CellModel]
    let onTapHandler: (CellModel) -> Void
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 20) {
            ForEach(cells, id: \.self) { cell in
                VStack(alignment: .leading, spacing: 10) {
                    CellInfoView(cell: cell) { cell in
                        onTapHandler(cell)
                    }
                }
                .sectionBackground()
            }
        }
    }
}

#Preview {
    CellFeedView(cells: [CellModel.mock, CellModel.mock]) { _ in
        
    }
}
