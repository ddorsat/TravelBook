//
//  ProfileViewModel.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import Foundation
import SwiftUI
import Combine

enum ProfileRoutes: Hashable {
    case loginRegister, login, register, loggedIn, appearance, notifications, aboutApp
}

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var profileRoutes: [ProfileRoutes] = []
    @Published private(set) var authState = AuthState.loggedOut
    @Published var isLoading = false
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    private var authService: any AuthServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(authService: any AuthServiceProtocol) {
        self.authService = authService
        
        setupSubscriptions()
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    private func setupSubscriptions() {
        authService.authState
            .receive(on: RunLoop.main)
            .sink { [weak self] authState in
                self?.authState = authState
            }
            .store(in: &cancellables)
    }
    
    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            showError("Пожалуйста, заполните все поля")
            return
        }
        
        isLoading = true
        
        Task {
            do {
                try await Task.sleep(for: .seconds(1))
                try await authService.login(email: email, password: password)
                
                profileRoutes = []
            } catch {
                handleError(error)
            }
            
            isLoading = false
        }
    }
    
    func register() {
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty else {
            showError("Пожалуйста, корректно заполните все поля")
            return
        }
        
        isLoading = true
        
        Task {
            do {
                try await Task.sleep(for: .seconds(1))
                try await authService.register(username: username, email: email, password: password)
                
                profileRoutes = []
            } catch {
                handleError(error)
            }
            
            isLoading = false
        }
    }
    
    func logOut() {
        authService.logOut()
        profileRoutes = []
    }
    
    private func handleError(_ error: Error) {
        if let authError = error as? NetworkError {
            showError(authError.errorDescription ?? "Произошла неизвестная ошибка")
        } else {
            showError(error.localizedDescription)
        }
    }
    
    private func showError(_ message: String) {
        self.showError = true
        self.errorMessage = message
    }
}



