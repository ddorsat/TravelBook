//
//  ProfileViewModel.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import Foundation
import Combine
import AlertKit

final class ProfileViewModel: ObservableObject {
    @Published var profileRoutes: [ProfileRoutes] = []
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published private(set) var authState = AuthState.signedOut
    @Published var showInvalidAlert = false
    @Published var invalidAlertMessage = ""
    @Published var showSignedInAlert = false
    @Published var showSignedUpAlert = false
    
    var signedInAlert = AlertAppleMusic17View(title: "Успешный вход", icon: .done)
    var signedUpAlert = AlertAppleMusic17View(title: "Успешная регистрация", icon: .done)
}

enum ProfileRoutes: Hashable {
    case signInUp, appearance, notifications, aboutApp, signIn, signUp, signedIn
}
