//
//  CellCategoriesView.swift
//  TravelBook
//
//  Created by ddorsat on 05.01.2026.
//

import SwiftUI

struct CategoryCellsView: View {
    @ObservedObject var vm: SearchViewModel
    let category: CategoryModel
    let onTapHandler: (CellModel) -> Void
    
    var body: some View {
        ZStack {
            Components.backgroundColor()

            if vm.searchResults.isEmpty {
                ContentUnavailableView("Пока нет данных 🙁", image: "")
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(vm.searchResults, id: \.self) { cell in
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
        }
        .navigationTitle(category.theme.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            vm.selectCategory(category.theme)
        }
        .bottomAreaPadding()
    }
}

#Preview {
    NavigationStack {
        CategoryCellsView(vm: SearchViewModel(contentService: ContentService()), category: .mock) { _ in
            
        }
    }
}
