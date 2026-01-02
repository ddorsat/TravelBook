//
//  SignedInView.swift
//  TravelBook
//
//  Created by ddorsat on 04.01.2026.
//

import SwiftUI

struct SignedInView: View {
    let onTapHandler: () -> Void
    
    var body: some View {
        List {
            Section {
                ProfileCellView(user: .mock, type: .logOut) {
                    onTapHandler()
                }
            }
            .navigationTitle("Профиль")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SignedInView() {
        
    }
}
