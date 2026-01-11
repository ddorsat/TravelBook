//
//  CellDetailsModel.swift
//  TravelBook
//
//  Created by ddorsat on 02.01.2026.
//

import Foundation

struct CellModel: Hashable, Identifiable, Codable {
    let id: UUID?
    let image: String
    let theme: Categories
    let title: String
    let subtitle: String
    let date: Date
    let readingTime: Int
    let description: String
    let images: [String]
    var isPopular: Bool
    var isHeadCell: Bool
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMM yyyy"
        return formatter.string(from: date)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, image, theme, title, subtitle, date, description, images
        case readingTime = "reading_time"
        case isPopular = "is_popular"
        case isHeadCell = "is_head_cell"
    }
}

extension CellModel {
    static let mock = CellModel(id: UUID(),
                                image: "test",
                                theme: .abroad,
                                title: "Как выбрать чемодан",
                                subtitle: "Гид по комфортным путешествиям",
                                date: .now,
                                readingTime: 5,
                                description: "Правильный чемодан — это инвестиция в спокойствие во время поездки. Мы разберем ключевые критерии выбора: что лучше — пластик или ткань, сколько должно быть колес для маневренности и как подобрать идеальный размер под требования авиакомпаний, чтобы ваш багаж всегда долетал в целости и сохранности.",
                                images: ["test", "test", "test"],
                                isPopular: true,
                                isHeadCell: true)
}
