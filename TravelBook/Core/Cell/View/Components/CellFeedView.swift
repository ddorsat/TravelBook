//
//  CellFeedView.swift
//  TravelBook
//
//  Created by ddorsat on 05.01.2026.
//

import SwiftUI

struct CellFeedView: View {
    let cell: [CellModel]
    let onTapHandler: (CellModel) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(cell, id: \.self) { cell in
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
    CellFeedView(cell: [CellModel.mock, CellModel.mock]) { _ in
        
    }
}
