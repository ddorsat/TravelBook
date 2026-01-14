//
//  SearchViewModel.swift
//  TravelBook
//
//  Created by ddorsat on 04.01.2026.
//

import Foundation
import Combine
import SwiftUI

enum SearchRoutes: Hashable {
    case searchFeedCellDetails(CellModel)
    case searchResults
    case searchResultsCellDetails(CellModel)
    case categories
    case categoryCells(CategoryModel)
    case categoryCellDetails(CellModel)
}

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var searchRoutes: [SearchRoutes] = []
    @Published var searchResults: [CellModel] = []
    @Published var searchText = ""
    @Published var selectedCategory: Categories? = nil
    @Published var cells: [CellModel] = []
    @Published var categories: [CategoryModel] = []
    
    let contentService: any ContentServiceProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(contentService: any ContentServiceProtocol) {
        self.contentService = contentService
        
        setupSubscriptions()
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    private func setupSubscriptions() {
        contentService.allCells
            .receive(on: RunLoop.main)
            .map { $0.shuffled() }
            .assign(to: \.cells, on: self)
            .store(in: &cancellables)
        
        contentService.allCategories
            .receive(on: RunLoop.main)
            .map { $0.shuffled() }
            .assign(to: \.categories, on: self)
            .store(in: &cancellables)
    }
    
    func searchData() async {
        var urlComponents = URLComponents(string: "\(Constants.address)/search")
        var queryItems: [URLQueryItem] = []
        
        if !searchText.isEmpty {
            queryItems.append(URLQueryItem(name: "search", value: searchText))
            searchRoutes.append(.searchResults)
            selectedCategory = nil
        } else if let category = selectedCategory {
            queryItems.append(URLQueryItem(name: "category", value: category.rawValue))
        }
        
        urlComponents?.queryItems = queryItems.isEmpty ? nil : queryItems
        
        guard let url = urlComponents?.url else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let items = try decoder.decode([CellModel].self, from: data)
            
            self.searchResults = items
        } catch {
            print("Ошибка поиска - \(error.localizedDescription)")
        }
    }
    
    func selectCategory(_ category: Categories) {
        selectedCategory = category
        searchText = ""
        
        let allData = contentService.allCells.value
        let filtered = allData.filter { $0.theme.rawValue == category.rawValue }
        
        self.searchResults = filtered
    }
    
    func refreshData() {
        Task { await contentService.fetchCells() }
    }
}

