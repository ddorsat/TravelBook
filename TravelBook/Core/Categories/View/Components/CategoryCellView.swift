//
//  CategoriesCellView.swift
//  TravelBook
//
//  Created by ddorsat on 02.01.2026.
//

import SwiftUI
import Kingfisher

struct CategoryCellView: View {
    let category: CategoryModel
    let onTapHandler: () -> Void
    
    var body: some View {
        Button(action: onTapHandler) {
            ZStack(alignment: .bottomLeading) {
                KFImage(URL(string: category.image))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width / 2.2,
                           height: UIScreen.main.bounds.height / 3.3)
                    .clipped()
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(category.theme.title)
                        .font(.system(size: 14))
                        .padding(7)
                        .background(category.theme.color)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                    Text(category.title)
                        .font(.system(size: 13))
                        .multilineTextAlignment(.leading)
                        .lineSpacing(3)
                        .lineLimit(3)
                }
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .padding(10)
            }
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}


#Preview {
    ForEach(CategoryModel.mockArray, id: \.self) { category in
        CategoryCellView(category: category) {
            
        }
        
        CategoryCellView(category: category) {
            
        }
    }
}
