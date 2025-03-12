//
//  SampleTabView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 11/3/25.
//

import SwiftUI

//struct RectangleData: Identifiable {
//    var id = UUID()
//    var color: Color
//}

struct SampleTabView: View {
    @State var selectedTab: Int = 0
//    let rectangleSet: [RectangleData] = [
//        RectangleData(color: Color.red),
//        RectangleData(color: Color.green),
//        RectangleData(color: Color.blue),
//        RectangleData(color: Color.yellow),
//        RectangleData(color: Color.cyan)
//    ]
//
//    var body: some View {
//        GeometryReader { geometry in
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 16) {
//                    ForEach(rectangleSet) { colorRectangle in
//                        Rectangle()
//                            .fill(colorRectangle.color)
//                            .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.6)
//                            .cornerRadius(16)
//                    }
//                }
//                .frame(height: geometry.size.width * 0.6)
//                .background(Color.gray)
//                .padding(.horizontal, (geometry.size.width - (geometry.size.width * 0.6)) / 2)
//                .scrollTargetLayout()
//            }
//        }
//        .scrollTargetBehavior(.viewAligned)
////        .safeAreaPadding([.horizontal], 16)
//    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Rectangle()
                .fill(Color.red)
                .frame(width: 80, height: 40)
                .tag(0)
            Rectangle()
                .fill(Color.blue)
                .frame(width: 80, height: 40)
                .tag(1)
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    SampleTabView()
}
