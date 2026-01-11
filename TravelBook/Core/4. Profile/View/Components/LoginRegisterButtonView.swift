//
//  SignInButtonView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI

struct LoginRegisterButtonView: View {
    let type: SignInButtons
    let onTapHandler: () -> Void
    
    var body: some View {
        Button(action: onTapHandler) {
            HStack {
                Image(systemName: type.icon)
                    .font(.system(size: type == .apple ? 23 : 18))
                    .foregroundStyle(type == .apple ? .white : .primary)
                    .fontWeight(type == .mail ? .semibold : .regular)
                    .padding(.leading, type == .apple ? 2 : 0)
                
                Spacer()
                    
                Text(type.rawValue)
                    .foregroundStyle(type == .apple ? .white : .black)
                    .fontWeight(.semibold)
                    .padding(.trailing, type == .mail ? 35 : 22)
                
                Spacer()
            }
            .padding(15)
            .frame(maxWidth: .infinity)
            .background(type == .apple ? .black : Color(uiColor: .systemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

enum SignInButtons: String {
    case apple = "Продолжить с Apple"
    case mail = "Почта"
    
    var icon: String {
        switch self {
            case .apple: return "apple.logo"
            case .mail: return "envelope"
        }
    }
}

#Preview {
    LoginRegisterButtonView(type: .apple) {
        
    }
    
    LoginRegisterButtonView(type: .mail) {
        
    }
}
