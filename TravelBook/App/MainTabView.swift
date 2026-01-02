//
//  MainTabView.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tabs = .feed
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(Tabs.feed.rawValue, systemImage: Tabs.feed.icon, value: .feed) {
                FeedView()
            }
            
            Tab(Tabs.search.rawValue, systemImage: Tabs.search.icon, value: .search) {
                SearchView()
            }
            
            Tab(Tabs.favorites.rawValue, systemImage: Tabs.favorites.icon, value: .favorites) {
                FavoritesView()
            }
            
            Tab(Tabs.profile.rawValue, systemImage: Tabs.profile.icon, value: .profile) {
                ProfileView()
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
}
