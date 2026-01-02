//
//  AuthService.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import Foundation
import Combine

enum AuthState {
    case signedIn(UserModel)
    case signedOut
}

protocol AuthProvider {
    var authState: CurrentValueSubject<AuthState, Never> { get }
    
    func autoLogin() async
    func signIn(email: String, password: String) async -> Bool
    func signUp(username: String, email: String, password: String) async -> Bool
    func signOut()
}

final class AuthService: AuthProvider {
    var authState = CurrentValueSubject<AuthState, Never>(.signedOut)
    
    init() {}
    
    func autoLogin() async {
        
    }
    
    func signIn(email: String, password: String) async -> Bool {
        return false
    }
    
    func signUp(username: String, email: String, password: String) async -> Bool {
        return false
    }
    
    func signOut() {
        
    }
}
