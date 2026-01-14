//
//  Components.swift
//  TravelBook
//
//  Created by ddorsat on 02.01.2026.
//

import Foundation
import SwiftUI

struct GridSetups {
    static let verticalGrid = [GridItem(.flexible(), spacing: 15, alignment: .top),
                                GridItem(.flexible(), spacing: 15, alignment: .top)]
    static let horizontalGrid = [GridItem(.flexible(), spacing: 15)]
}

struct Components {
    static func headerView(_ title: String) -> some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.leading, 2)
    }
    
    static func customDivider(isFavorites: Bool) -> some View {
        Rectangle()
            .foregroundStyle(.divider)
            .frame(height: 0.5)
            .padding(.leading, isFavorites ? 81 : 15)
            .padding(.top, isFavorites ? 5 : 0)
            .horizontalPadding(false)
    }
    
    static func bigLogo() -> some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .frame(width: 65, height: 65)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color(uiColor: .systemGray3))
            }
    }
    
    static func categoriesTheme(_ category: Categories, _ size: CategoriesThemeSizes) -> some View {
        Text(category.title)
            .foregroundStyle(.white)
            .font(size.title)
            .fontWeight(.semibold)
            .padding(5)
            .background(category.color)
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
    enum CategoriesThemeSizes {
        case feed, search
        
        var title: Font {
            switch self {
                case .feed: return .footnote
                case .search: return .system(size: 15)
            }
        }
    }
    
    static func backgroundColor() -> some View {
        return Color(uiColor: .background).ignoresSafeArea(edges: .bottom)
    }
}

struct RoundedPolygon: Shape {
    var sides: Int = 6
    var cornerRadius: CGFloat = 15
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        let angle = (Double.pi * 2) / Double(sides)
        
        let points: [CGPoint] = (0..<sides).map { i in
            let currentAngle = angle * Double(i) - (Double.pi / 2)
            let x = center.x + CGFloat(cos(currentAngle)) * radius
            let y = center.y + CGFloat(sin(currentAngle)) * radius
            return CGPoint(x: x, y: y)
        }
        
        path.move(to: CGPoint(x: (points[0].x + points.last!.x)/2, y: (points[0].y + points.last!.y)/2))
        
        for i in 0..<sides {
            let p = points[i]
            let nextP = points[(i + 1) % sides]
            path.addArc(tangent1End: p, tangent2End: nextP, radius: cornerRadius)
        }
        
        path.closeSubpath()
        return path
    }
}
