//
//  SignedInView.swift
//  TravelBook
//
//  Created by ddorsat on 04.01.2026.
//

import SwiftUI

struct LoggedInView: View {
    @State private var showConfirmLogOut = false
    @ObservedObject var vm: ProfileViewModel
    
    var body: some View {
        List {
            Section {
                ProfileCellView(user: .mock, type: .logOut) {
                    showConfirmLogOut.toggle()
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Профиль")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Подтвердите выход", isPresented: $showConfirmLogOut) {
                Button("Выйти", role: .cancel) { vm.logOut() }
                Button("Отмена", role: .confirm) {}
            }
        }
    }
}

#Preview {
    LoggedInView(vm: ProfileViewModel(authService: AuthService()))
}
