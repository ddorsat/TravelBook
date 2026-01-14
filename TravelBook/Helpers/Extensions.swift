//
//  CustomExtensions.swift
//  TravelBook
//
//  Created by ddorsat on 04.01.2026.
//

import Foundation
import SwiftUI

extension UIDevice {
    static var isProMax: Bool {
        UIScreen.main.bounds.width >= 430
    }
}

extension View {
    func bottomAreaPadding() -> some View {
        self
            .safeAreaInset(edge: .bottom) { Color.clear.frame(height: 50) }
    }
    
    func horizontalPadding(_ negative: Bool) -> some View {
        self
            .padding(.horizontal, negative ? 13 : -13)
    }
    
    func sectionBackground() -> some View {
        self
            .horizontalPadding(true)
            .padding(.vertical, 15)
            .background(.feedCellBackground)
    }
}

extension ColorScheme {
    var isLight: Bool {
        self == .light
    }
}
