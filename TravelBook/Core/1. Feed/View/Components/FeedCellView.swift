//
//  FeedCellView.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import SwiftUI
import Kingfisher

struct FeedCellView: View {
    let cell: CellModel
    let onTapHandler: () -> Void
    
    var body: some View {
        Button(action: onTapHandler) {
            VStack(alignment: .leading, spacing: 10) {
                KFImage(URL(string: cell.image))
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width / 2.2,
                           height: UIScreen.main.bounds.height / 7)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(cell.title)
                    .foregroundStyle(.title)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .padding(.leading, 3)
                    .lineLimit(2)
                    .lineHeight(.exact(points: 20))
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

#Preview {
    HStack {
        FeedCellView(cell: .mock) {
            
        }
        
        FeedCellView(cell: .mock) {
            
        }
    }
}
