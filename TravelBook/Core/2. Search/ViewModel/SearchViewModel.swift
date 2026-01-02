//
//  SearchViewModel.swift
//  TravelBook
//
//  Created by ddorsat on 04.01.2026.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    @Published var searchRoutes: [SearchRoutes] = []
}

enum SearchRoutes: Hashable {
    case categories, cellCategories(CategoryModel), cellCategoriesDetails(CellModel), cellDetails(CellModel)
}
