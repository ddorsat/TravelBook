//
//  CellBuilderView.swift
//  TravelBook
//
//  Created by ddorsat on 04.01.2026.
//

import SwiftUI

struct CellBuilderView: View {
    let cell: CellModel
    let isSearch: Bool
    let isCellDetails: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: isSearch ? 13 : 15) {
            if isSearch {
                Components.categoriesTheme(cell.theme, .search)
            }
            
            Text(cell.title)
                .font(.title)
                .fontWeight(.semibold)
            
            Text(cell.subtitle)
                .foregroundStyle(Color(uiColor: .darkGray))
                .font(.callout)
                .fontWeight(.bold)
            
            HStack(spacing: isCellDetails ? 15 : 10) {
                Text("\(cell.dateString)")
                Divider()
                Text("\(cell.readingTime) мин")
                Divider()
                
                if isCellDetails {
                    Button {
                        
                    } label: {
                        Image(systemName: "heart")
                            .imageScale(.large)
                            .foregroundStyle(.red)
                    }
                }
            }
            .foregroundStyle(Color.gray)
            .font(.subheadline)
            .fontWeight(.medium)
            
            Text(cell.description)
                .foregroundStyle(Color(uiColor: .darkGray))
                .fontWeight(.medium)
                .lineSpacing(6)
                .padding(.vertical, isSearch ? 15 : 17)
                .lineLimit(isSearch ? 6 : .max)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .multilineTextAlignment(.leading)
    }
}

/*
 Button {
     
 } label: {
     Image(systemName: "heart")
         .foregroundStyle(.red)
         .font(.system(size: 23))
         .padding(.trailing, 10)
 }
 */

#Preview {
    CellBuilderView(cell: .mock, isSearch: true, isCellDetails: true)
}
