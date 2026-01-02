//
//  NotificationsView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        List {
            Section {
                Toggle("Новости", isOn: .constant(true))
            } header: {
                Text("PUSH")
                    .font(.callout)
                    .foregroundStyle(.gray)
                    .fontWeight(.medium)
            }
            .listRowBackground(Color(uiColor: .systemGroupedBackground))
        }
        .navigationTitle("Уведомления")
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    NotificationsView()
}
