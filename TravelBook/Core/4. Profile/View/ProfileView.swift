//
//  ProfileView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var vm: ProfileViewModel
    
    init(authService: any AuthServiceProtocol) {
        _vm = StateObject(wrappedValue: ProfileViewModel(authService: authService))
    }
    
    var body: some View {
        NavigationStack(path: $vm.profileRoutes) {
            List {
                Section {
                    switch vm.authState {
                        case .loggedIn(let user):
                            ProfileCellView(user: user, type: .signedIn) {
                                vm.profileRoutes.append(.loggedIn)
                            }
                        case .loggedOut:
                            ProfileCellView(user: .mock, type: .signInUp) {
                                vm.profileRoutes.append(.loginRegister)
                            }
                    }
                } header: {
                    Color.clear.frame(height: 70)
                }
                .listRowBackground(Color(uiColor: .background))
                
                Section {
                    ProfileCellView(user: .mock, type: .appearance) {
                        vm.profileRoutes.append(.appearance)
                    }
                        
                    ProfileCellView(user: .mock, type: .notifications) {
                        vm.profileRoutes.append(.notifications)
                    }
                }
                .listRowBackground(Color(uiColor: .background))
                    
                Section {
                    ProfileCellView(user: .mock, type: .aboutApp) {
                        vm.profileRoutes.append(.aboutApp)
                    }
                }
                .listRowBackground(Color(uiColor: .background))
            }
            .listSectionSpacing(100)
            .scrollContentBackground(.hidden)
            .navigationTitle("Профиль")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: ProfileRoutes.self) { destination in
                destinationView(destination)
            }
        }
    }
}

extension ProfileView {
    @ViewBuilder
    private func destinationView(_ route: ProfileRoutes) -> some View {
        switch route {
            case .loginRegister:
                LoginRegisterView(vm: vm)
            case .login:
                LoginRegisterBuilderView(vm: vm, type: .login)
            case .register:
                LoginRegisterBuilderView(vm: vm, type: .register)
            case .loggedIn:
                LoggedInView(vm: vm)
            case .appearance:
                AppearanceView()
            case .notifications:
                NotificationsView()
            case .aboutApp:
                AboutAppView()
        }
    }
}

#Preview {
    ProfileView(authService: AuthService())
}
