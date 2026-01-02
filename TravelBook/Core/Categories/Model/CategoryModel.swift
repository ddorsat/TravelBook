//
//  CategoriesModel.swift
//  TravelBook
//
//  Created by ddorsat on 02.01.2026.
//

import Foundation
import SwiftUI

struct CategoryModel: Hashable, Codable {
    let image: String
    let theme: Categories
    let title: String
    let cells: [CellModel]
}

extension CategoryModel {
    static let mock = CategoryModel(image: "fraud", theme: .fraud, title: "Как не стать жертвой обмана", cells: [])
    
    static let mockArray: [CategoryModel] = [
        CategoryModel(image: "abroad", theme: .abroad, title: "Главный чек-лист перед выездом", cells: []),
        CategoryModel(image: "fraud", theme: .fraud, title: "Как не стать жертвой обмана", cells: []),
        CategoryModel(image: "leisure", theme: .leisure, title: "ТОП-10 развлечений для активного отдыха", cells: CellModel.leisureMockArray),
        CategoryModel(image: "food", theme: .food, title: "Гастрономический туризм: что пробовать", cells: CellModel.foodMockArray),
        CategoryModel(image: "tickets", theme: .tickets, title: "Ловим дешевые авиабилеты", cells: []),
        CategoryModel(image: "packing", theme: .packing, title: "Как собрать чемодан за 15 минут", cells: []),
        CategoryModel(image: "culture", theme: .culture, title: "Языковой барьер и местные традиции", cells: []),
        CategoryModel(image: "health", theme: .health, title: "Что должно быть в аптечке туриста", cells: []),
        CategoryModel(image: "family", theme: .family, title: "Путешествия с маленькими детьми", cells: []),
        CategoryModel(image: "budget", theme: .budget, title: "Как сэкономить 30% бюджета поездки", cells: [])]
}

enum Categories: String, Codable, CaseIterable {
    case abroad, fraud, leisure, food, tickets, packing, culture, health, family, budget
        
    var title: String {
        switch self {
            case .abroad: return "Заграница"
            case .fraud: return "Безопасность"
            case .leisure: return "Развлечения"
            case .food: return "Еда"
            case .tickets: return "Билеты"
            case .packing: return "Багаж"
            case .culture: return "Культура"
            case .health: return "Здоровье"
            case .family: return "С детьми"
            case .budget: return "Экономия"
        }
    }
    
    var color: Color {
        switch self {
            case .abroad: return .orange
            case .fraud: return .red
            case .leisure: return .purple
            case .food: return .green
            case .tickets: return .blue
            case .packing: return .brown
            case .culture: return .indigo
            case .health: return .mint
            case .family: return .yellow
            case .budget: return .teal
        }
    }
}
