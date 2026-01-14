//
//  MainTabView.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var favoritesService: FavoritesService
    @EnvironmentObject var contentService: ContentService
    
    @State private var selectedTab: Tabs = .feed
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(Tabs.feed.rawValue, systemImage: Tabs.feed.icon, value: .feed) {
                FeedView(contentService: contentService,
                         authService: authService,
                         favoritesService: favoritesService)
            }
            
            Tab(Tabs.search.rawValue, systemImage: Tabs.search.icon, value: .search) {
                SearchView(contentService: contentService,
                           authService: authService,
                           favoritesService: favoritesService)
            }
            
            Tab(Tabs.favorites.rawValue, systemImage: Tabs.favorites.icon, value: .favorites) {
                FavoritesView(authService: authService,
                              favoritesService: favoritesService)
            }
            
            Tab(Tabs.profile.rawValue, systemImage: Tabs.profile.icon, value: .profile) {
                ProfileView(authService: authService)
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

fileprivate enum Tabs: String {
    case feed = "Лента"
    case search = "Поиск"
    case favorites = "Избранное"
    case profile = "Профиль"
    
    var icon: String {
        switch self {
            case .feed: return "house"
            case .search: return "magnifyingglass"
            case .favorites: return "heart"
            case .profile: return "person"
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(ContentService())
        .environmentObject(AuthService())
        .environmentObject(FavoritesService())
}
