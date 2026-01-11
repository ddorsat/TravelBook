//
//  SignedInView.swift
//  TravelBook
//
//  Created by ddorsat on 04.01.2026.
//

import SwiftUI

struct LoggedInView: View {
    @ObservedObject var vm: ProfileViewModel
    
    var body: some View {
        List {
            Section {
                ProfileCellView(user: .mock, type: .logOut) {
                    vm.logOut()
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Профиль")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LoggedInView(vm: ProfileViewModel(authService: AuthService()))
}
