//
//  CellDetailsView.swift
//  TravelBook
//
//  Created by ddorsat on 02.01.2026.
//

import SwiftUI

struct CellDetailsView: View {
    let cell: CellModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(cell.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height / 3.5)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .horizontalPadding(false)
                
                CellBuilderView(cell: cell, isSearch: false, isCellDetails: true)
                
                TabView {
                    ForEach(cell.images, id: \.self) { image in
                        Image(image)
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
    CellDetailsView(cell: .mock)
}
