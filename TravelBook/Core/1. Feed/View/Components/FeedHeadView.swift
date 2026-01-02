//
//  FeedHeadView.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import SwiftUI

struct FeedHeadView: View {
    let cell: CellModel
    let onTapHandler: () -> Void
    
    var body: some View {
        Button(action: onTapHandler) {
            ZStack(alignment: .topLeading) {
                Image(cell.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: .infinity, height: UIScreen.main.bounds.height / 6)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                VStack(alignment: .leading, spacing: 10) {
                    Text(cell.title)
                        .font(.title3)
                        .fontWeight(.heavy)
                    
                    Text(cell.subtitle)
                        .font(.callout)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
                .padding(.top, 23)
                .padding(.leading, 18)
            }
        }
    }
}

#Preview {
    FeedHeadView(cell: .mock) {
        
    }
}
