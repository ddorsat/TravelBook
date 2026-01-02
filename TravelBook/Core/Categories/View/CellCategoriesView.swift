//
//  CellCategoriesView.swift
//  TravelBook
//
//  Created by ddorsat on 05.01.2026.
//

import SwiftUI

struct CellCategoriesView: View {
    let category: CategoryModel
    let onTapHandler: (CellModel) -> Void
    
    var body: some View {
        ZStack {
            Components.backgroundColor(onlyBottom: true)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(category.cells, id: \.self) { cell in
                        VStack(alignment: .leading, spacing: 10) {
                            CellInfoView(cell: cell) { cell in
                                onTapHandler(cell)
                            }
                        }
                        .whiteBackground()
                    }
                }
            }
        }
        .navigationTitle(category.theme.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .bottomAreaPadding()
    }
}

#Preview {
    NavigationStack {
        CellCategoriesView(category: .mock) { _ in
            
        }
    }
}
