//
//  AppearanceView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI

struct AppearanceView: View {
    @State private var selectedTheme: AppTheme = .light
    
    var body: some View {
        List {
            Section {
                ForEach(AppTheme.allCases, id: \.self) { theme in
                    Button {
                        selectedTheme = theme
                    } label: {
                        HStack {
                            Text(theme.rawValue)
                                .foregroundStyle(.primary)
                                                        
                            Spacer()
                                                        
                            if selectedTheme == theme {
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
}

#Preview {
    AppearanceView()
}
