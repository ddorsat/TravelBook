//
//  AuthService.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import Foundation
import Combine

enum AuthState {
    case loggedIn(UserModel)
    case loggedOut
}

protocol AuthServiceProtocol: ObservableObject {
    var authState: CurrentValueSubject<AuthState, Never> { get }
    
    func register(username: String, email: String, password: String) async throws
    func login(email: String, password: String) async throws
    func logOut()
}

final class AuthService: AuthServiceProtocol {
    var authState = CurrentValueSubject<AuthState, Never>(.loggedOut)
    
    private let url = "\(Constants.address)/auth"
    private let tokenPath = Constants.tokenPath
    private let tokenKey = Constants.tokenKey
    private let userKey = Constants.userKey
    
    init() { autoLogin() }
    
    func register(username: String, email: String, password: String) async throws {
        let url = "\(url)/register"
        let body = UserData(username: username, email: email, password: password)
        
        let _ = try await NetworkHelper.request(url: url, method: "POST", body: body)
        
        try await login(email: email, password: password)
    }
    
    func login(email: String, password: String) async throws {
        let url = "\(url)/login"
        let body = UserData(email: email, password: password)
        let data = try await NetworkHelper.request(url: url, method: "POST", body: body)
        
        do {
            let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
            
            saveToken(tokenResponse.token)
            saveUserLocally(tokenResponse.user)
            
            await MainActor.run {
                authState.send(.loggedIn(tokenResponse.user))
            }
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func logOut() {
        KeychainHelper.standard.delete(path: tokenPath, key: tokenKey)
        UserDefaults.standard.removeObject(forKey: userKey)
        
        authState.send(.loggedOut)
    }
    
    private func autoLogin() {
        if let _ = KeychainHelper.standard.read(path: tokenPath, key: tokenKey),
           let userData = UserDefaults.standard.data(forKey: userKey),
           let user = try? JSONDecoder().decode(UserModel.self, from: userData) {
            authState.send(.loggedIn(user))
        } else {
            authState.send(.loggedOut)
        }
    }
    
    private func saveUserLocally(_ user: UserModel) {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: userKey)
        }
    }
    
    private func saveToken(_ token: String) {
        if let data = token.data(using: .utf8) {
            KeychainHelper.standard.save(data, path: tokenPath, key: tokenKey)
        }
    }
}

private struct UserData: Encodable {
    let username: String?
    let email: String
    let password: String
    
    init(username: String? = nil, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
}

private struct TokenResponse: Decodable {
    let token: String
    let user: UserModel
}
