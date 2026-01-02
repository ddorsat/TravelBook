//
//  FavoritesView.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var vm = FavoritesViewModel()
    
    var body: some View {
        NavigationStack(path: $vm.favoritesRoutes) {
            List(CellModel.mockArray, id: \.self) { cell in
                FavoritesCellView(cell: cell) {
                    vm.favoritesRoutes.append(.cellDetails(cell))
                }
                .listRowSeparator(.hidden)
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
        }
    }
}

extension FavoritesView {
    private func destinationView(_ route: FavoritesRoutes) -> some View {
        switch route {
            case .cellDetails(let cell):
                CellDetailsView(cell: cell)
        }
    }
}

#Preview {
    FavoritesView()
}
