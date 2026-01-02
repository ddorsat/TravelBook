//
//  ProfileView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var vm = ProfileViewModel()
    
    var body: some View {
        NavigationStack(path: $vm.profileRoutes) {
            List {
                Section {
                    ProfileCellView(user: .mock, type: .signInUp) {
                        vm.profileRoutes.append(.signInUp)
                    }
                        
//                    ProfileCellView(user: .mock, type: .signedIn) {
//                        vm.profileRoutes.append(.signedIn)
//                    }
                } header: {
                    Color.clear.frame(height: 70)
                }
                .listRowBackground(Color(uiColor: .systemGroupedBackground))
                
                Section {
                    ProfileCellView(user: .mock, type: .appearance) {
                        vm.profileRoutes.append(.appearance)
                    }
                        
                    ProfileCellView(user: .mock, type: .notifications) {
                        vm.profileRoutes.append(.notifications)
                    }
                }
                .listRowBackground(Color(uiColor: .systemGroupedBackground))
                    
                Section {
                    ProfileCellView(user: .mock, type: .aboutApp) {
                        vm.profileRoutes.append(.aboutApp)
                    }
                }
                .listRowBackground(Color(uiColor: .systemGroupedBackground))
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
            case .signInUp:
                SignInUpView {
                    // APPLE SIGN IN/UP
                } signInButton: {
                    vm.profileRoutes.append(.signIn)
                } signUpButton: {
                    vm.profileRoutes.append(.signUp)
                }
            case .appearance:
                AppearanceView()
            case .notifications:
                NotificationsView()
            case .aboutApp:
                AboutAppView()
            case .signIn:
                SignInUpBuilderView(email: $vm.email,
                                    password: $vm.password,
                                    showInvalidAlert: $vm.showInvalidAlert,
                                    invalidAlertMessage: $vm.invalidAlertMessage,
                                    showSignedInAlert: $vm.showSignedInAlert,
                                    signedInAlertMessage: $vm.signedInAlert,
                                    clearUsername: nil) {
                    vm.email = ""
                } clearPassword: {
                    vm.password = ""
                } onTapHandler: {
                    
                }
            case .signUp:
                SignInUpBuilderView(username: $vm.username,
                                    email: $vm.email,
                                    password: $vm.password,
                                    showInvalidAlert: $vm.showInvalidAlert,
                                    invalidAlertMessage: $vm.invalidAlertMessage,
                                    showSignedInAlert: $vm.showSignedInAlert,
                                    signedInAlertMessage: $vm.signedUpAlert) {
                    vm.username = ""
                } clearEmail: {
                    vm.email = ""
                } clearPassword: {
                    vm.password = ""
                } onTapHandler: {
                    
                }
            case .signedIn:
                SignedInView() {
                        
            }
        }
    }
}

#Preview {
    ProfileView()
}
