//
//  TrendingCellView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI

struct TrendingCellView: View {
    let category: CategoryModel
    let onTapHandler: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            Button(action: onTapHandler) {
                Image(category.image)
                    .resizable()
                    .frame(width: 37, height: 37)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 2)
                            .foregroundStyle(.white)
                    }
                
                Text(category.theme.rawValue)
                    .fontWeight(.medium)
            }
            
            Spacer()
            
            Button(action: onTapHandler) {
                Text("Перейти")
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Color(uiColor: .systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 7))
            }
        }
        .foregroundStyle(.black)
        .padding(.vertical, 10)
    }
}

#Preview {
    TrendingCellView(category: .mockArray[0]) {
        
    }
}
