//
//  SearchView.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var vm = SearchViewModel()
    @State private var searchText = ""
    @State private var isShown = false

    var body: some View {
        NavigationStack(path: $vm.searchRoutes) {
            ZStack {
                Components.backgroundColor(onlyBottom: true)

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Components.headerView("Категории")

                                Spacer()

                                Button("Ещё") {
                                    vm.searchRoutes.append(.categories)
                                }
                            }

                            Components.customDivider()

                            ForEach(CategoryModel.mockArray.prefix(upTo: 3),
                                    id: \.self) { category in
                                TrendingCellView(category: category) {
                                    vm.searchRoutes.append(.cellCategories(category))
                                }
                            }
                        }
                        .padding(.top, 3)
                        .whiteBackground()
                        .padding(.top, 20)

                        VStack(alignment: .leading, spacing: 10) {
                            Components.headerView("Посты")
                            
                            Components.customDivider()
                        }
                        .padding(.top, 3)
                        .whiteBackground()

                        CellFeedView(cell: .mock) { cell in
                            vm.searchRoutes.append(.cellDetails(cell))
                        }
                        .padding(.top, -30)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(CellModel.mockArray, id: \.self) { cell in
                                VStack(alignment: .leading, spacing: 10) {
                                    CellInfoView(cell: cell) { cell in
                                        vm.searchRoutes.append(.cellDetails(cell))
                                    }
                                }
                                .whiteBackground()
                            }
                        }
                        .padding(.top, -30)
                    }
                }
                .navigationTitle("Поиск")
                .navigationBarTitleDisplayMode(.inline)
                .bottomAreaPadding()
                .scrollIndicators(.hidden)
                .searchable(text: $searchText,
                            placement: .navigationBarDrawer(displayMode: .automatic),
                            prompt: "Поиск")
                .navigationDestination(for: SearchRoutes.self,
                                       destination: destinationView)
            }
        }
    }
}

extension SearchView {
    @ViewBuilder
    private func destinationView(_ destination: SearchRoutes) -> some View {
        switch destination {
            case .categories:
                CategoriesView() { category in
                    vm.searchRoutes.append(.cellCategories(category))
                }
            case .cellCategories(let category):
                CellCategoriesView(category: category) { cell in
                    vm.searchRoutes.append(.cellCategoriesDetails(cell))
                }
            case .cellCategoriesDetails(let cell):
                CellDetailsView(cell: cell)
            case .cellDetails(let cell):
                CellDetailsView(cell: cell)
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
