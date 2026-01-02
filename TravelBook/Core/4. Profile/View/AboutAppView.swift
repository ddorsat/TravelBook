//
//  AboutAppView.swift
//  TravelBook
//
//  Created by ddorsat on 03.01.2026.
//

import SwiftUI

struct AboutAppView: View {
    var body: some View {
        VStack(spacing: 25) {
            Components.bigLogo()
                
            VStack(spacing: 10) {
                Text("УЧЕБНИК ПУТЕШЕСТВИЙ")
                    .foregroundStyle(.gray)
                    .fontDesign(.monospaced)
                    .fontWeight(.medium)
                    
                Text("1.0.0")
                    .fontWeight(.semibold)
            }
                
            Spacer()
        }
        .navigationTitle("О приложении")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top, 25)
    }
}

#Preview {
    NavigationStack {
        AboutAppView()
    }
}
