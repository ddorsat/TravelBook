//
//  CellInfoView.swift
//  TravelBook
//
//  Created by ddorsat on 04.01.2026.
//

import SwiftUI

struct CellInfoView: View {
    let cell: CellModel
    let onTapHandler: (CellModel) -> Void
    
    var body: some View {
        Button {
            onTapHandler(cell)
        } label: {
            VStack(alignment: .leading) {
                CellBuilderView(cell: cell, isSearch: true, isCellDetails: false)
                    
                Text("Читать далее")
                    .foregroundStyle(.blue)
                    .padding(.bottom, 5)
            }
        }
        .foregroundStyle(.black)
    }
}

#Preview {
    CellInfoView(cell: .mock) { _ in
        
    }
}
