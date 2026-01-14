//
//  CellDetailsView.swift
//  TravelBook
//
//  Created by ddorsat on 02.01.2026.
//

import SwiftUI
import Combine
import Kingfisher

struct CellDetailsView: View {
    @StateObject private var vm: CellDetailsViewModel
    @State private var showAuthAlert = false
    let cell: CellModel
    let authService: any AuthServiceProtocol
    
    init(cell: CellModel,
         authService: any AuthServiceProtocol,
         favoritesService: any FavoritesServiceProtocol) {
        self.cell = cell
        self.authService = authService
        _vm = StateObject(wrappedValue: CellDetailsViewModel(cell: cell, favoritesService: favoritesService))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                KFImage(URL(string: cell.image))
                    .resizable()
                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height / 3.5)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .horizontalPadding(false)
                
                CellBuilderView(cell: cell,
                                isSearch: false,
                                isCellDetails: true,
                                isFavorite: $vm.isFavorite) {
                    if case .loggedIn = authService.authState.value {
                        vm.toggleFavorite()
                    } else {
                        withAnimation {
                            vm.isFavorite?.toggle()
                        }
                        
                        showAuthAlert = true
                    }
                }
                
                TabView {
                    ForEach(cell.images, id: \.self) { image in
                        KFImage(URL(string: image))
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    }
                }
                .frame(height: UIScreen.main.bounds.height / 3.8)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .horizontalPadding(true)
            .bottomAreaPadding()
            .padding(.top, -117)
            .alert("Пожалуйста, авторизуйтесь или зарегистрируйтесь", isPresented: $showAuthAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}
#Preview {
    CellDetailsView(cell: .mock,
                    authService: AuthService(),
                    favoritesService: FavoritesService())
}
