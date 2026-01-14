//
//  ContentService.swift
//  TravelBook
//
//  Created by ddorsat on 13.01.2026.
//

import Foundation
import Combine

protocol ContentServiceProtocol: ObservableObject {
    var feedCells: CurrentValueSubject<[CellModel], Never> { get }
    var searchCells: CurrentValueSubject<[CellModel], Never> { get }
    var popularCells: CurrentValueSubject<[CellModel], Never> { get }
    var allCategories: CurrentValueSubject<[CategoryModel], Never> { get }
    
    var canLoadMoreFeed: CurrentValueSubject<Bool, Never> { get }
    var canLoadMoreSearch: CurrentValueSubject<Bool, Never> { get }
    
    func fetchData() async
    func fetchMoreFeedCells() async
    func fetchSearchCells() async
    func fetchMoreSearchCells() async
}

final class ContentService: ContentServiceProtocol {
    var feedCells = CurrentValueSubject<[CellModel], Never>([])
    var searchCells = CurrentValueSubject<[CellModel], Never>([])
    var popularCells = CurrentValueSubject<[CellModel], Never>([])
    var allCategories = CurrentValueSubject<[CategoryModel], Never>([])
    
    var canLoadMoreFeed = CurrentValueSubject<Bool, Never>(false)
    var canLoadMoreSearch = CurrentValueSubject<Bool, Never>(false)
    
    private var isFeedLoading = false
    private var isSearchLoading = false
    
    private var currentFeedSeed = UUID().uuidString
    private var currentSearchSeed = UUID().uuidString
    
    private var limit = 6
    private var feedPage = 1
    private var searchPage = 1
    
    private let baseURL = Constants.address
    
    init() {}
    
    func fetchData() async {
        feedPage = 1
        canLoadMoreFeed.send(true)
        
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.fetchFeedCells() }
            group.addTask { await self.fetchSearchCells() }
            group.addTask { await self.fetchCategories() }
            group.addTask { await self.fetchPopularCells() }
        }
    }
    
    func fetchFeedCells() async {
        await fetchCells(pagePath: \.feedPage,
                         loadingPath: \.isFeedLoading,
                         canLoadSubjectPath: \.canLoadMoreFeed,
                         cellsSubjectPath: \.feedCells,
                         isRefreshing: true)
    }
    
    func fetchMoreFeedCells() async {
        guard canLoadMoreFeed.value, !isFeedLoading else { return }
        
        await fetchCells(pagePath: \.feedPage,
                         loadingPath: \.isFeedLoading,
                         canLoadSubjectPath: \.canLoadMoreFeed,
                         cellsSubjectPath: \.feedCells,
                         isRefreshing: false)
    }
    
    func fetchSearchCells() async {
        await fetchCells(pagePath: \.searchPage,
                         loadingPath: \.isSearchLoading,
                         canLoadSubjectPath: \.canLoadMoreSearch,
                         cellsSubjectPath: \.searchCells,
                         isRefreshing: true)
    }
    
    func fetchMoreSearchCells() async {
        guard canLoadMoreSearch.value, !isSearchLoading else { return }
        
        await fetchCells(pagePath: \.searchPage,
                         loadingPath: \.isSearchLoading,
                         canLoadSubjectPath: \.canLoadMoreSearch,
                         cellsSubjectPath: \.searchCells,
                         isRefreshing: false)
    }
    
    private func fetchCells(pagePath: ReferenceWritableKeyPath<ContentService, Int>,
                            loadingPath: ReferenceWritableKeyPath<ContentService, Bool>,
                            canLoadSubjectPath: KeyPath<ContentService, CurrentValueSubject<Bool, Never>>,
                            cellsSubjectPath: KeyPath<ContentService, CurrentValueSubject<[CellModel], Never>>,
                            isRefreshing: Bool) async {
        if isRefreshing {
            self[keyPath: pagePath] = 1
            
            if pagePath == \.feedPage {
                self.currentFeedSeed = UUID().uuidString
            } else if pagePath == \.searchPage {
                self.currentSearchSeed = UUID().uuidString
            }
        }
        
        self[keyPath: loadingPath] = true
        
        let currentPage = self[keyPath: pagePath]
        let seed = (pagePath == \.feedPage) ? currentFeedSeed : currentSearchSeed
        let url = "\(baseURL)/cells?page=\(currentPage)&limit=\(limit)&seed=\(seed)"
        
        do {
            let newCells: [CellModel] = try await NetworkHelper.fetch(url: url)
            
            await MainActor.run {
                let cellsSubject = self[keyPath: cellsSubjectPath]
                let canLoadSubject = self[keyPath: canLoadSubjectPath]
                
                if isRefreshing {
                    cellsSubject.send(newCells)
                } else {
                    var current = cellsSubject.value
                    current.append(contentsOf: newCells)
                    cellsSubject.send(current)
                }
                
                let hasMore = newCells.count == self.limit
                canLoadSubject.send(hasMore)
                
                if hasMore {
                    self[keyPath: pagePath] += 1
                }
                
                self[keyPath: loadingPath] = false
            }
        } catch {
            print("ContentService - Ошибка fetchCells")
            await MainActor.run { self[keyPath: loadingPath] = false }
        }
    }
    
    private func fetchPopularCells() async {
        let url = "\(baseURL)/popular"
        
        do {
            let loadedPopularCells: [CellModel] = try await NetworkHelper.fetch(url: url)
            
            await MainActor.run { self.popularCells.send(loadedPopularCells) }
        } catch {
            print("Content Service - Ошибка fetch popularCells")
        }
    }
    
    private func fetchCategories() async {
        let url = "\(baseURL)/categories"
        
        do {
            let loadedCategories: [CategoryModel] = try await NetworkHelper.fetch(url: url)
            
            await MainActor.run { self.allCategories.send(loadedCategories) }
        } catch {
            print("Content Service - Ошибка fetch categories")
        }
    }
}
