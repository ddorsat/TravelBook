//
//  SignView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI

enum LoginRegisterBuilderType: String {
    case login = "Войти"
    case register = "Регистрация"
}

struct LoginRegisterBuilderView: View {
    @ObservedObject var vm: ProfileViewModel
    let type: LoginRegisterBuilderType
    
    var body: some View {
        List {
            Section {
                if type == .register {
                    HStack {
                        TextField("Имя", text: $vm.username)
                        
                        Spacer()
                        
                        customXmark(isShown: !vm.username.isEmpty) {
                            vm.username = ""
                        }
                    }
                }
                
                HStack {
                    TextField("Почта", text: $vm.email)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    
                    Spacer()
                    
                    customXmark(isShown: !vm.email.isEmpty) {
                        vm.email = ""
                    }
                }
                
                HStack {
                    SecureField("Пароль", text: $vm.password)
                        .textContentType(type == .register ? .newPassword : .password)
                    
                    Spacer()
                    
                    customXmark(isShown: !vm.password.isEmpty) {
                        vm.password = ""
                    }
                }
            }
            .listRowBackground(Color(uiColor: .systemGroupedBackground))
        }
        .scrollContentBackground(.hidden)
        .navigationTitle(type.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            navButton()
        }
        .alert(Text(vm.errorMessage), isPresented: $vm.showError) {
            Button("OK", role: .cancel) {}
        }
        .onDisappear {
            vm.username = ""
            vm.email = ""
            vm.password = ""
        }
    }
}

extension LoginRegisterBuilderView {
    @ToolbarContentBuilder
    private func navButton() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            if vm.isLoading {
                ProgressView()
            } else {
                Button {
                    if type == .register {
                        vm.register()
                    } else {
                        vm.login()
                    }
                } label: {
                    Text("Далее")
                }
            }
        }
    }
    
    private func customXmark(isShown: Bool, _ completion: @escaping () -> Void) -> some View {
        Button(action: completion) {
            Image(systemName: "xmark")
                .font(.system(size: 10))
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .padding(4)
                .background(Color(uiColor: .systemGray4))
                .clipShape(Circle())
                .opacity(isShown ? 1 : 0)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            NavigationStack {
                LoginRegisterBuilderView(vm: ProfileViewModel(authService: AuthService()), type: .login)
            }
        }
    }
    
    return PreviewWrapper()
}
