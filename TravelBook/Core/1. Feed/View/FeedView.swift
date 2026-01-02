//
//  MainView.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var vm = FeedViewModel()
    
    var body: some View {
        NavigationStack(path: $vm.feedRoutes) {
            ZStack {
                Components.backgroundColor(onlyBottom: true)
                
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
                            
                            FeedHeadView(cell: vm.cells.first ?? .mock) {
                                vm.feedRoutes.append(.headCell)
                            }
                        }
                        .whiteBackground()
                        
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Components.headerView("Популярное")
                                
                                Spacer()
                                
                                Button {
                                    vm.feedRoutes.append(.popular(CellModel.mock))
                                } label: {
                                    Text("Ещё")
                                        .foregroundStyle(.blue)
                                }
                            }
                            
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: GridSetups.horizontalGrid, spacing: 15) {
                                    ForEach(vm.cells, id: \.self) { cell in
                                        FeedBigCellView(cell: cell) {
                                            vm.feedRoutes.append(.bigCell(cell))
                                        }
                                    }
                                }
                                .horizontalPadding(true)
                            }
                            .horizontalPadding(false)
                        }
                        .whiteBackground()
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Components.headerView("Лента")
                            
                            LazyVGrid(columns: GridSetups.verticalGrid, spacing: 25) {
                                ForEach(vm.cells, id: \.self) { cell in
                                    FeedCellView(cell: cell) {
                                        vm.feedRoutes.append(.feedCell(cell))
                                    }
                                }
                            }
                        }
                        .whiteBackground()
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
            .task {
                await vm.fetchData()
            }
        }
    }
}

extension FeedView {
    @ViewBuilder
    private func destinationView(_ route: FeedRoutes) -> some View {
        switch route {
            case .headCell:
                CellDetailsView(cell: .mock)
            case .popular(let cell):
                PopularView(cell: cell) { cell in
                    vm.feedRoutes.append(.cellDetails(cell))
                }
            case .bigCell(let cell):
                CellDetailsView(cell: cell)
            case .feedCell(let cell):
                CellDetailsView(cell: cell)
            case .cellDetails(let cell):
                CellDetailsView(cell: cell)
        }
    }
}

#Preview {
    NavigationStack {
        FeedView()
    }
}
