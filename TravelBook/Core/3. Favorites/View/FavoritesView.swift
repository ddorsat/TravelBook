//
//  FavoritesView.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var vm: FavoritesViewModel
    
    let authService: any AuthServiceProtocol
    
    init(authService: any AuthServiceProtocol,
         favoritesService: any FavoritesServiceProtocol) {
        self.authService = authService
        _vm = StateObject(wrappedValue: FavoritesViewModel(authService: authService, favoritesService: favoritesService))
    }
    
    var body: some View {
        NavigationStack(path: $vm.favoritesRoutes) {
            Group {
                if vm.favorites.isEmpty {
                    ContentUnavailableView("Нет избранного", systemImage: "")
                } else {
                    List(vm.favorites, id: \.id) { cell in
                        FavoritesCellView(cell: cell) {
                            vm.favoritesRoutes.append(.cellDetails(cell))
                        } handleFavorite: { _ in
                            vm.handleFavoriteToggle(for: cell)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
            }
            .navigationTitle("Избранное")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .listRowSpacing(-5)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .bottomAreaPadding()
            .navigationDestination(for: FavoritesRoutes.self) { destination in
                destinationView(destination)
            }
            .refreshable {
                vm.fetchFavorites()
            }
            .onAppear {
                vm.fetchFavorites()
            }
        }
    }
}

extension FavoritesView {
    @ViewBuilder
    private func destinationView(_ route: FavoritesRoutes) -> some View {
        switch route {
            case .cellDetails(let cell):
                CellDetailsView(cell: cell,
                                authService: authService,
                                favoritesService: vm.favoritesService)
        }
    }
}

#Preview {
    FavoritesView(authService: AuthService(), favoritesService: FavoritesService())
}
