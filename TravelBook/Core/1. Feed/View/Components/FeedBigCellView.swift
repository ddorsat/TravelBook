//
//  FeedBigCellView.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import SwiftUI
import Kingfisher

struct FeedBigCellView: View {
    @Environment(\.colorScheme) private var colorScheme
    let cell: CellModel
    let onTapHandler: () -> Void
    
    var body: some View {
        Button(action: onTapHandler) {
            VStack(alignment: .leading, spacing: 12) {
                Components.categoriesTheme(cell.theme, .feed)
                    
                Text(cell.title)
                    .font(.system(size: 14))
                    .foregroundStyle(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .lineSpacing(5)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    KFImage(URL(string: cell.image))
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIDevice.isProMax ? 155 : 145, height: UIDevice.isProMax ? 155 : 145)
                        .clipShape(RoundedPolygon(sides: 6, cornerRadius: 12))
                }
            }
            .padding(15)
            .frame(width: UIScreen.main.bounds.width / 1.8, height: UIScreen.main.bounds.height / 2.9)
            .background(cell.theme.color.opacity(colorScheme.isLight ? 0.1 : 0.18))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}



#Preview {
    FeedBigCellView(cell: .mock) {
        
    }
}
