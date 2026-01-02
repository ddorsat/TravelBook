//
//  WelcomeView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI

struct SignInUpView: View {
    let appleButton: () -> Void
    let signInButton: () -> Void
    let signUpButton: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Components.bigLogo()
                
            Text("Вход в аккаунт")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 25)
                
            VStack(spacing: 18) {
                SignInUpButtonView(type: .apple) {
                    appleButton()
                }
                
                SignInUpButtonView(type: .mail) {
                    signInButton()
                }
                
                HStack {
                    Text("Нет аккаунта?")
                        .foregroundStyle(.gray)
                    
                    Button {
                        signUpButton()
                    } label: {
                        Text("Регистрация")
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
        SignInUpView() {
            
        } signInButton: {
            
        } signUpButton: {
            
        }
    }
}
