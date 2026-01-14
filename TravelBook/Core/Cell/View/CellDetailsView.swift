//
//  CellDetailsView.swift
//  TravelBook
//
//  Created by ddorsat on 02.01.2026.
//

import SwiftUI
import Kingfisher

struct CellDetailsView: View {
    @StateObject private var vm: CellDetailsViewModel
    let cell: CellModel
    
    init(cell: CellModel, favoritesService: any FavoritesServiceProtocol) {
        self.cell = cell
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
                    vm.toggleFavorite()
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
        }
    }
}
#Preview {
    CellDetailsView(cell: .mock, favoritesService: FavoritesService())
}
