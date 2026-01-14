//
//  ContentService.swift
//  TravelBook
//
//  Created by ddorsat on 13.01.2026.
//

import Foundation
import Combine

protocol ContentServiceProtocol: ObservableObject {
    var allCells: CurrentValueSubject<[CellModel], Never> { get }
    var allCategories: CurrentValueSubject<[CategoryModel], Never> { get }
    
    func fetchData() async
    func fetchCells() async
}

final class ContentService: ContentServiceProtocol {
    var allCells = CurrentValueSubject<[CellModel], Never>([])
    var allCategories = CurrentValueSubject<[CategoryModel], Never>([])
    
    private let baseURL = Constants.address
    
    init() {}
    
    func fetchData() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.fetchCells() }
            group.addTask { await self.fetchCategories() }
        }
    }
    
    func fetchCells() async {
        let url = "\(baseURL)/cells"
        
        do {
            let loadedCells: [CellModel] = try await NetworkHelper.fetch(url: url)
            await MainActor.run { self.allCells.send(loadedCells) }
        } catch {
            print("Content Service - Ошибка fetch cells")
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
