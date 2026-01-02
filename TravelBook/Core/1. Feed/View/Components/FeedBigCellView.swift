//
//  FeedBigCellView.swift
//  TravelBook
//
//  Created by ddorsat on 01.01.2026.
//

import SwiftUI

struct FeedBigCellView: View {
    let cell: CellModel
    let onTapHandler: () -> Void
    
    var body: some View {
        Button(action: onTapHandler) {
            VStack(alignment: .leading, spacing: 12) {
                Components.categoriesTheme(cell.theme, .feed)
                    
                Text(cell.title)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .lineSpacing(5)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image(cell.image)
                        .resizable()
                        .frame(width: UIDevice.isProMax ? 145 : 135, height: UIDevice.isProMax ? 145 : 135)
                        .scaledToFill()
                        .clipShape(RoundedPolygon(sides: 6, cornerRadius: 12))
                }
            }
            .padding(15)
            .foregroundStyle(.black)
            .frame(width: UIScreen.main.bounds.width / 1.8, height: UIScreen.main.bounds.height / 2.9)
            .background(cell.theme.color.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}



#Preview {
    FeedBigCellView(cell: .mock) {
        
    }
}
