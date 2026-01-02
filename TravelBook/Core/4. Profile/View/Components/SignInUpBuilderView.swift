//
//  SignView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI
import AlertKit

struct SignInUpBuilderView: View {
    var username: Binding<String>? = nil
    @Binding var email: String
    @Binding var password: String
    
    @Binding var showInvalidAlert: Bool
    @Binding var invalidAlertMessage: String
    @Binding var showSignedInAlert: Bool
    @Binding var signedInAlertMessage: AlertAppleMusic17View
    
    let clearUsername: (() -> Void)?
    let clearEmail: () -> Void
    let clearPassword: () -> Void
    let onTapHandler: () -> Void
    
    private var isValid: Bool {
        if let username, username.wrappedValue.isEmpty {
            return false
        }
        
        if password.count < 6 { return false }
            
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    var body: some View {
        List {
            Section {
                if let username {
                    HStack {
                        TextField("Имя", text: username)
                        
                        Spacer()
                        
                        customXmark(isShown: !username.wrappedValue.isEmpty) {
                            clearUsername?()
                        }
                    }
                }
                
                HStack {
                    TextField("Почта", text: $email)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    
                    Spacer()
                    
                    customXmark(isShown: !email.isEmpty) {
                        clearEmail()
                    }
                }
                
                HStack {
                    SecureField("Пароль", text: $password)
                        .textContentType(username != nil ? .newPassword : .password)
                    
                    Spacer()
                    
                    customXmark(isShown: !password.isEmpty) {
                        clearPassword()
                    }
                }
            }
            .listRowBackground(Color(uiColor: .systemGroupedBackground))
        }
        .scrollContentBackground(.hidden)
        .navigationTitle(username != nil ? "Регистрация" : "Войти")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            navButton()
        }
        .alert(invalidAlertMessage, isPresented: $showInvalidAlert) {
            Button("OK", role: .cancel) { }
        }
        .alert(isPresent: $showSignedInAlert, view: signedInAlertMessage)
        .onDisappear {
            email = ""
            password = ""
            
            if let username { username.wrappedValue = "" }
            
            showInvalidAlert = false
            showSignedInAlert = false
        }
    }
}

extension SignInUpBuilderView {
    @ToolbarContentBuilder
    private func navButton() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    onTapHandler()
                }
            } label: {
                Text("Далее")
                    .fontWeight(isValid ? .medium : .regular)
            }
            .disabled(!isValid)
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
        @State var name = ""
        @State var email = ""
        @State var pass = ""
        @State var showErr = false
        @State var errMsg = "Неверные данные"
        @State var showSignedIn = false
        @State var signedInMsg = AlertAppleMusic17View(title: "Успешный вход", icon: .done)
        
        var body: some View {
            NavigationStack {
                SignInUpBuilderView(username: $name,
                                    email: $email,
                                    password: $pass,
                                    showInvalidAlert: $showErr,
                                    invalidAlertMessage: $errMsg,
                                    showSignedInAlert: $showSignedIn,
                                    signedInAlertMessage: $signedInMsg) {
                    
                } clearEmail: {
                    
                } clearPassword: {
                    
                } onTapHandler: {
                    
                }
            }
        }
    }
    
    return PreviewWrapper()
}
