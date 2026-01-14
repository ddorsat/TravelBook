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
    @Published var canLoadMore = false
    
    let contentService: any ContentServiceProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(contentService: any ContentServiceProtocol) {
        self.contentService = contentService
        self.cells = contentService.searchCells.value
        self.categories = contentService.allCategories.value
        
        setupSubscriptions()
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    private func setupSubscriptions() {
        contentService.searchCells
            .receive(on: RunLoop.main)
            .assign(to: \.cells, on: self)
            .store(in: &cancellables)
        
        contentService.allCategories
            .receive(on: RunLoop.main)
            .assign(to: \.categories, on: self)
            .store(in: &cancellables)
        
        contentService.canLoadMoreSearch
            .receive(on: RunLoop.main)
            .assign(to: \.canLoadMore, on: self)
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
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            switch httpResponse.statusCode {
                case 200...299:
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let items = try decoder.decode([CellModel].self, from: data)
                    
                    self.searchResults = items
                case 401:
                    throw NetworkError.incorrentLoginCredentials
                case 409:
                    throw NetworkError.userAlreadyExists
                default:
                    throw NetworkError.apiError(message: "Status: \(httpResponse.statusCode)")
            }
        } catch {
            print("Ошибка поиска - \(error.localizedDescription)")
        }
    }
    
    func selectCategory(_ category: Categories) {
        selectedCategory = category
        searchText = ""
        
        let allData = contentService.feedCells.value
        let filtered = allData.filter { $0.theme.rawValue == category.rawValue }
        
        self.searchResults = filtered
    }
    
    func fetchMoreCells() {
        Task { await contentService.fetchMoreSearchCells() }
    }
    
    func refreshData() {
        Task { await contentService.fetchData() }
    }
}

