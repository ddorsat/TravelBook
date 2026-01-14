//
//  FavoritesCellView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI
import Kingfisher

struct FavoritesCellView: View {
    @State private var isLiked: Bool = true
    let cell: CellModel
    let onTapHandler: () -> Void
    let handleFavorite: (Bool) -> Void
    
    var body: some View {
        Button(action: onTapHandler) {
            VStack {
                HStack {
                    KFImage(URL(string: cell.image))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                    VStack(alignment: .leading, spacing: 7) {
                        Text(cell.title)
                            .fontWeight(.medium)
                            .lineLimit(1)
                                
                        Text(cell.description)
                            .font(.footnote)
                            .fontWeight(.light)
                            .lineLimit(2)
                    }
                    
                    Spacer()
                    
                    Button {
                        isLiked.toggle()
                        handleFavorite(isLiked)
                    } label: {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundStyle(isLiked ? .red : .gray)
                            .padding(.bottom, 30)
                            .contentTransition(.symbolEffect(.replace))
                    }
                }
                
                Components.customDivider(isFavorites: true)
            }
        }
    }
}

#Preview {
    FavoritesCellView(cell: .mock) {
        
    } handleFavorite: { _ in
        
    }
}
