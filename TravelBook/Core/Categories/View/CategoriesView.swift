//
//  CategoriesView.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import SwiftUI

struct CategoriesView: View {
    let gridSetup = [GridItem(.flexible(), spacing: 15, alignment: .top),
                     GridItem(.flexible(), spacing: 15, alignment: .top)]
    let onTapHandler: (CategoryModel) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridSetup, alignment: .leading, spacing: 15) {
                ForEach(CategoryModel.mockArray, id: \.self) { category in
                    CategoriesCellView(category: category) {
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
    CategoriesView() { _ in
        
    }
}
