//
//  TrendingCellView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI
import Kingfisher

struct CategoriesSmallView: View {
    let category: CategoryModel
    let onTapHandler: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            Button(action: onTapHandler) {
                KFImage(URL(string: category.image))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .frame(width: 37, height: 37)
                    .clipShape(Circle())
                
                Text(category.theme.title)
                    .foregroundStyle(.title)
                    .fontWeight(.medium)
            }
            
            Spacer()
            
            Button(action: onTapHandler) {
                Text("Перейти")
                    .foregroundStyle(.title)
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
    CategoriesSmallView(category: .mockArray[0]) {
        
    }
}
