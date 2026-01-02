//
//  UserModel.swift
//  TravelBook
//
//  Created by ddorsat on 04.01.2026.
//

import Foundation

struct UserModel: Identifiable {
    let id: Int
    let username: String
    let email: String
}

extension UserModel {
    static let mock = UserModel(id: 1, username: "Dmitry", email: "test@test.com")
}
