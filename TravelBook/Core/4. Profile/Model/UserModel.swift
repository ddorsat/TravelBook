//
//  UserModel.swift
//  TravelBook
//
//  Created by ddorsat on 04.01.2026.
//

import Foundation

struct UserModel: Identifiable, Codable {
    let id: UUID
    let username: String?
    let email: String
    
    init(id: UUID, username: String? = nil, email: String) {
        self.id = id
        self.username = username
        self.email = email
    }
}

extension UserModel {
    static let mock = UserModel(id: UUID(), username: "Dmitry", email: "test@test.com")
}
