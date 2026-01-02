//
//  FeedViewModel.swift
//  TravelBook
//
//  Created by ddorsat on 05.01.2026.
//

import Foundation
import SwiftUI
import Combine

final class FeedViewModel: ObservableObject {
    @Published var feedRoutes: [FeedRoutes] = []
    @Published var cells: [CellModel] = []
    
    func fetchData() async {
        guard let url = URL(string: "http://127.0.0.1:8080/feed") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let loadedCells = try decoder.decode([CellModel].self, from: data)
            
            withAnimation {
                self.cells = loadedCells
            }
        } catch {
            print("Ошибка загрузки - \(error.localizedDescription)")
        }
    }
}

enum FeedRoutes: Hashable {
    case headCell, popular(CellModel), bigCell(CellModel), feedCell(CellModel), cellDetails(CellModel)
}
