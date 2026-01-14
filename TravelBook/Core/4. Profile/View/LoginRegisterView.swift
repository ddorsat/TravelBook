//
//  WelcomeView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI

struct LoginRegisterView: View {
    @ObservedObject var vm: ProfileViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Components.bigLogo()
                
            Text("Вход в аккаунт")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 25)
                
            VStack(spacing: 20) {
                VStack(spacing: 15) {
                    LoginRegisterButtonView(type: .apple) {
                        // APPLE REGISTER
                    }
                    
                    LoginRegisterButtonView(type: .mail) {
                        vm.profileRoutes.append(.login)
                    }
                }
                
                HStack {
                    Text("Нет аккаунта?")
                        .foregroundStyle(.gray)
                    
                    Button {
                        vm.profileRoutes.append(.register)
                    } label: {
                        Text("Регистрация")
                            .foregroundStyle(.blue)
                            .fontWeight(.medium)
                    }
                }
            }
            
        }
        .padding(.bottom, UIDevice.isProMax ? 135 : 115)
        .padding(.horizontal, 40)
    }
}

#Preview {
    NavigationStack {
        LoginRegisterView(vm: ProfileViewModel(authService: AuthService()))
    }
}
