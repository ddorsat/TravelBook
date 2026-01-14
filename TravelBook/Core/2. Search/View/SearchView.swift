//
//  SearchView.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var vm: SearchViewModel
    @State private var isShown = false
    
    let contentService: any ContentServiceProtocol
    let authService: any AuthServiceProtocol
    let favoritesService: any FavoritesServiceProtocol
    
    init(contentService: any ContentServiceProtocol,
         authService: any AuthServiceProtocol,
         favoritesService: any FavoritesServiceProtocol) {
        self.contentService = contentService
        self.authService = authService
        self.favoritesService = favoritesService
        
        _vm = StateObject(wrappedValue: SearchViewModel(contentService: contentService))
    }

    var body: some View {
        NavigationStack(path: $vm.searchRoutes) {
            ZStack {
                Components.backgroundColor()

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

                            Components.customDivider(isFavorites: false)

                            ForEach(vm.categories.prefix(3),
                                    id: \.self) { category in
                                CategoriesSmallView(category: category) {
                                    vm.searchRoutes.append(.categoryCells(category))
                                }
                            }
                        }
                        .padding(.top, 3)
                        .sectionBackground()
                        .padding(.top, 20)

                        VStack(alignment: .leading, spacing: 10) {
                            Components.headerView("Посты")
                            
                            Components.customDivider(isFavorites: false)
                        }
                        .padding(.top, 3)
                        .sectionBackground()

                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(vm.cells, id: \.self) { cell in
                                VStack(alignment: .leading, spacing: 10) {
                                    CellInfoView(cell: cell) { cell in
                                        vm.searchRoutes.append(.searchFeedCellDetails(cell))
                                    }
                                }
                                .sectionBackground()
                            }
                        }
                        .padding(.top, -30)
                    }
                }
                .navigationTitle("Поиск")
                .navigationBarTitleDisplayMode(.inline)
                .bottomAreaPadding()
                .scrollIndicators(.hidden)
                .searchable(text: $vm.searchText,
                            placement: .navigationBarDrawer(displayMode: .automatic),
                            prompt: "Поиск")
                .onSubmit(of: .search) {
                    Task { await vm.searchData() }
                }
                .navigationDestination(for: SearchRoutes.self,
                                       destination: destinationView)
                .refreshable {
                    vm.refreshData()
                }
            }
        }
    }
}

extension SearchView {
    @ViewBuilder
    private func destinationView(_ destination: SearchRoutes) -> some View {
        switch destination {
            case .searchFeedCellDetails(let cell):
                CellDetailsView(cell: cell,
                                authService: authService,
                                favoritesService: favoritesService)
            case .searchResults:
                SearchResultsView(vm: vm) { cell in
                    vm.searchRoutes.append(.searchResultsCellDetails(cell))
                }
            case .searchResultsCellDetails(let cell):
                CellDetailsView(cell: cell,
                                authService: authService,
                                favoritesService: favoritesService)
            case .categories:
                CategoriesView(categories: vm.categories) { category in
                    vm.searchRoutes.append(.categoryCells(category))
                }
            case .categoryCells(let category):
                CategoryCellsView(vm: vm, category: category) { cell in
                    vm.searchRoutes.append(.categoryCellDetails(cell))
                }
            case .categoryCellDetails(let cell):
                CellDetailsView(cell: cell,
                                authService: authService, 
                                favoritesService: favoritesService)
        }
    }
}

#Preview {
    NavigationStack {
        SearchView(contentService: ContentService(),
                   authService: AuthService(),
                   favoritesService: FavoritesService())
    }
}
