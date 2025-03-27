//
//  SwipeHighlightTagDemo.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/3/25.
//

import SwiftUI

struct ColorSet: Identifiable {
    var id = UUID()
    var color: Color
    var isSelected: Bool = false
}

struct HighlightSwitcherView: View {
    
    @State var colorCircles: [ColorSet] = [
        ColorSet(color: Color.red),
        ColorSet(color: Color.green),
        ColorSet(color: Color.blue),
        ColorSet(color: Color.yellow)
    ]
    
    let circleSize: CGFloat = 200
    var isSelected: Bool = true
    
    var body: some View {
        GeometryReader { geoParent in
            let sizeParent = geoParent.frame(in: .global)
            let midXParent = sizeParent.width / 2
            let padding = (sizeParent.width - circleSize) / 2
            
            ScrollView (.horizontal) {
                HStack (spacing: 24) {
                    ForEach($colorCircles) { $color in
                        GeometryReader { geoChild in
                            let sizeXChild = geoChild.frame(in: .local)
                            let midXChild = sizeXChild.width / 2
                            
                            Rectangle()
                                .fill(color.color)
                                .frame(width: circleSize, height: 40)
                                .onAppear {
                                    print("Mid X of rectangle: \(midXChild)")
                                }
                        }
                        .frame(width: circleSize, height: 40) // rất quan trọng để layout đúng
                    }
                }
                .padding(.horizontal, padding)
                .scrollTargetLayout()
                .onAppear {
                    print("Parent size: \(sizeParent.width)")
                    print("Mid X: \(midXParent)")
                }
            }
            .scrollTargetBehavior(.viewAligned)
            .frame(height: sizeParent.height)
            .background(curiPalette(.paper500))
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    HighlightSwitcherView()
}
