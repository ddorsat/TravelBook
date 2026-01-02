//
//  FavoritesCellView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI

struct FavoritesCellView: View {
    let cell: CellModel
    let onTapHandler: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Image(cell.image)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 2)
                            .foregroundStyle(.white)
                    }
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
                
                Button(action: onTapHandler) {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                        .padding(.bottom, 30)
                }
            }
            
            Divider()
                .padding(.leading, 81)
                .padding(.top, 5)
                .horizontalPadding(false)
        }
    }
}

#Preview {
    FavoritesCellView(cell: .mock) {
        
    }
}
