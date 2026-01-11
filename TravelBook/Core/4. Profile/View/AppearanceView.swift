//
//  AppearanceView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI

struct AppearanceView: View {
    @StateObject private var vm = AppearanceViewModel()
    
    var body: some View {
        List {
            Section {
                ForEach(AppTheme.allCases, id: \.self) { theme in
                    Button {
                        vm.setTheme(theme)
                    } label: {
                        HStack {
                            Text(theme.rawValue)
                                .foregroundStyle(.primary)
                                                        
                            Spacer()
                                                        
                            if vm.currentTheme == theme {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.blue)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
            } header: {
                Text("ТЕМА ПРИЛОЖЕНИЯ")
                    .font(.callout)
                    .foregroundStyle(.gray)
                    .fontWeight(.medium)
            }
            .listRowBackground(Color(uiColor: .systemGroupedBackground))
        }
        .navigationTitle("Оформление")
        .navigationBarTitleDisplayMode(.inline)
        .foregroundStyle(.black)
        .scrollContentBackground(.hidden)
    }
}

enum AppTheme: String, CaseIterable {
    case light = "Светлая"
    case dark = "Темная"
    case system = "Системная"
    
    var colorScheme: ColorScheme? {
        switch self {
            case .light: return .light
            case .dark: return .dark
            case .system: return nil
        }
    }
}

#Preview {
    AppearanceView()
}
