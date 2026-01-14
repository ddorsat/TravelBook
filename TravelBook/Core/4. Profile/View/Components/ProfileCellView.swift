//
//  ProfileCellView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI

struct ProfileCellView: View {
    let user: UserModel
    let type: ProfileTabs
    let onTapHandler: () -> Void
    
    private var isSignedIn: Bool {
        return type == .signedIn
    }
    
    var body: some View {
        Button(action: onTapHandler) {
            HStack(spacing: 15) {
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .foregroundStyle(type.backgroundColor)
                        .frame(width: isSignedIn ? 45 : 35, height: isSignedIn ? 45 : 35)
                        .overlay(alignment: .bottom) {
                            if isSignedIn {
                                Image("user")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 35, height: 35)
                            }
                        }
                        .clipShape(isSignedIn ? RoundedRectangle(cornerRadius: 25) : RoundedRectangle(cornerRadius: 5))
                    
                    if !isSignedIn {
                        Image(systemName: type.icon)
                            .foregroundStyle(.white)
                            .font(.system(size: 22))
                    }
                }
                
                if type == .signedIn {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(user.username ?? user.email)
                            .foregroundStyle(.title)
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                        Text("@" + user.id.uuidString.suffix(5))
                            .foregroundStyle(Color(uiColor: .gray))
                            .font(.system(size: 13))
                    }
                } else {
                    Text(type.rawValue)
                        .foregroundStyle(type == .signInUp ? .blue : .primary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color(uiColor: .systemGray3))
                    .fontWeight(.semibold)
            }
        }
    }
}

enum ProfileTabs: String {
    case signedIn
    case signInUp = "Вход и регистрация"
    case appearance = "Оформление"
    case notifications = "Уведомления"
    case aboutApp = "О приложении"
    case logOut = "Выйти"
    
    var icon: String {
        switch self {
            case .signedIn: return "person"
            case .signInUp: return "person.crop.circle.fill"
            case .appearance: return "paintpalette.fill"
            case .notifications: return "bell.fill"
            case .aboutApp: return "info.circle.fill"
            case .logOut: return "rectangle.portrait.and.arrow.right"
        }
    }
    
    var backgroundColor: Color {
        switch self {
            case .signedIn: return Color(uiColor: .systemGray5)
            case .signInUp: return .blue
            case .appearance: return .green
            case .notifications: return .orange
            case .aboutApp: return .gray
            case .logOut: return .red
        }
    }
}

#Preview {
    VStack {
        ProfileCellView(user: .mock, type: .signInUp) {
            
        }
    }
    .padding(.horizontal)
}
