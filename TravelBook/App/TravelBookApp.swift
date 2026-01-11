//
//  TravelBookApp.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import SwiftUI

@main
struct TravelBookApp: App {
    @StateObject private var authService = AuthService()
    @StateObject private var contentService = ContentService()
    @StateObject private var favoritesService = FavoritesService()
    
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(authService)
                .environmentObject(contentService)
                .environmentObject(favoritesService)
                .preferredColorScheme(selectedTheme.colorScheme)
        }
    }
}
