//
//  CategoriesView.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import SwiftUI

struct CategoriesView: View {
    let categories: [CategoryModel]
    let gridSetup = [GridItem(.flexible(), spacing: 15, alignment: .top),
                     GridItem(.flexible(), spacing: 15, alignment: .top)]
    let onTapHandler: (CategoryModel) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridSetup, alignment: .leading, spacing: 15) {
                ForEach(categories, id: \.self) { category in
                    CategoryCellView(category: category) {
                        onTapHandler(category)
                    }
                }
            }
            .horizontalPadding(true)
        }
        .navigationTitle("Категории")
        .bottomAreaPadding()
    }
}

#Preview {
    CategoriesView(categories: CategoryModel.mockArray) { _ in
        
    }
}
