//
//  FavoritesViewModel.swift
//  TravelBook
//
//  Created by ddorsat on 05.01.2026.
//

import Foundation
import Combine

final class FavoritesViewModel: ObservableObject {
    @Published var favoritesRoutes: [FavoritesRoutes] = []
}

enum FavoritesRoutes: Hashable {
    case cellDetails(CellModel)
}
