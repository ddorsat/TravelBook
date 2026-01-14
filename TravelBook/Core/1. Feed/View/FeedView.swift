//
//  MainView.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var vm: FeedViewModel
    
    let contentService: any ContentServiceProtocol
    let authService: any AuthServiceProtocol
    let favoritesService: any FavoritesServiceProtocol
    
    init(contentService: any ContentServiceProtocol,
         authService: any AuthServiceProtocol,
         favoritesService: any FavoritesServiceProtocol) {
        self.contentService = contentService
        self.authService = authService
        self.favoritesService = favoritesService
        
        _vm = StateObject(wrappedValue: FeedViewModel(contentService: contentService, favoritesService: favoritesService))
    }
    
    var body: some View {
        NavigationStack(path: $vm.feedRoutes) {
            if vm.cells.isEmpty {
                ProgressView()
            } else {
                ZStack {
                    Components.backgroundColor()
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 15) {
                                HStack(spacing: 10) {
                                    Image("logo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 38, height: 38)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    
                                    VStack(alignment: .leading, spacing: -1) {
                                        Text("УЧЕБНИК")
                                        Text("ПУТЕШЕСТВИЙ")
                                    }
                                    .font(.footnote)
                                    .fontDesign(.rounded)
                                    .fontWeight(.heavy)
                                    
                                    Spacer()
                                }
                                
                                if let head = vm.headCell {
                                    FeedHeadView(cell: head) {
                                        vm.feedRoutes.append(.headCell(head))
                                    }
                                }
                            }
                            .sectionBackground()
                            
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Components.headerView("Популярное")
                                    
                                    Spacer()
                                    
                                    Button {
                                        vm.feedRoutes.append(.popular)
                                    } label: {
                                        Text("Ещё")
                                            .foregroundStyle(.blue)
                                    }
                                }
                                
                                ScrollView(.horizontal) {
                                    LazyHGrid(rows: GridSetups.horizontalGrid, spacing: 15) {
                                        ForEach(vm.popularCells, id: \.self) { cell in
                                            FeedBigCellView(cell: cell) {
                                                vm.feedRoutes.append(.bigCell(cell))
                                            }
                                        }
                                    }
                                    .horizontalPadding(true)
                                }
                                .horizontalPadding(false)
                            }
                            .sectionBackground()
                            
                            VStack(alignment: .leading, spacing: 20) {
                                Components.headerView("Лента")
                                
                                LazyVGrid(columns: GridSetups.verticalGrid, spacing: 25) {
                                    Section {
                                        ForEach(vm.cells, id: \.self) { cell in
                                            FeedCellView(cell: cell) {
                                                vm.feedRoutes.append(.feedCell(cell))
                                            }
                                        }
                                    } footer: {
                                        if vm.canLoadMore {
                                            ProgressView()
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 50)
                                                .onAppear {
                                                    vm.fetchMoreCells()
                                                }
                                        }
                                    }
                                }
                            }
                            .sectionBackground()
                        }
                    }
                }
                .navigationTitle("Лента")
                .navigationBarTitleDisplayMode(.inline)
                .scrollIndicators(.hidden)
                .bottomAreaPadding()
                .navigationDestination(for: FeedRoutes.self) { destination in
                    destinationView(destination)
                }
                .refreshable {
                    vm.fetchData()
                }
            }
        }
    }
}

extension FeedView {
    @ViewBuilder
    private func destinationView(_ route: FeedRoutes) -> some View {
        switch route {
            case .headCell(let cell):
                CellDetailsView(cell: cell,
                                authService: authService,
                                favoritesService: favoritesService)
            case .popular:
                PopularView(cells: vm.popularCells) { cell in
                    vm.feedRoutes.append(.cellDetails(cell))
                }
            case .bigCell(let cell), .feedCell(let cell), .cellDetails(let cell):
                CellDetailsView(cell: cell,
                                authService: authService,
                                favoritesService: favoritesService)
        }
    }
}

#Preview {
    NavigationStack {
        FeedView(contentService: ContentService(),
                 authService: AuthService(),
                 favoritesService: FavoritesService())
    }
}
