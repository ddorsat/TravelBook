//
//  SearchResultsView.swift
//  TravelBook
//
//  Created by ddorsat on 05.01.2026.
//

import SwiftUI

struct SearchResultsView: View {
    @ObservedObject var vm: SearchViewModel
    let onTapHandler: (CellModel) -> Void
    
    var body: some View {
        ZStack {
            Components.backgroundColor()
            
            ScrollView {
                CellFeedView(cells: vm.searchResults) { cell in
                    onTapHandler(cell)
                }
            }
        }
        .navigationTitle("Поиск")
        .navigationBarTitleDisplayMode(.inline)
        .bottomAreaPadding()
    }
}

#Preview {
    NavigationStack {
        SearchResultsView(vm: SearchViewModel(contentService: ContentService())) { _ in
            
        }
    }
}
