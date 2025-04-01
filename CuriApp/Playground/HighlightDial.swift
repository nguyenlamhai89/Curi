//
//  HighlightDial.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/4/25.
//

import SwiftUI

struct HighlightDialTest: View {
    let items = ["SwiftUI Carousel", "Short Text", "A very long text that should be trimmed", "Centered Item", "Another Item"]
    
    @State private var selectedIndex: Int = 0
    var body: some View {
        SmoothCarouselView()
    }
}

#Preview {
    SmoothCarouselView()
}

struct CarouselView: View {
    let items = ["SwiftUI Carousel", "Short Text", "A very long text that should be trimmed", "Centered Item", "Another Item"]
    
    @State private var selectedIndex: Int = 0
    @State private var scrollOffset: CGFloat = 0
    @State private var isDragging = false
    @Namespace private var scrollSpace
    
    var body: some View {
        GeometryReader { geometry in
            let cardWidth = geometry.size.width * 0.4
            let spacing: CGFloat = 20
            
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { scrollProxy in
                    HStack(spacing: spacing) {
                        ForEach(items.indices, id: \.self) { index in
                            let isSelected = selectedIndex == index
                            
                            Text(String(items[index].prefix(20)))
                                .font(.headline)
                                .frame(width: cardWidth, height: 40)
                                .background(isSelected ? Color.blue.opacity(0.7) : Color.gray.opacity(0.3))
                                .cornerRadius(15)
                                .shadow(radius: isSelected ? 10 : 5)
                                .scaleEffect(isSelected ? 1.1 : 1.0)
                                .id(index)
                        }
                    }
                    .padding(.horizontal, (geometry.size.width - cardWidth) / 2 - spacing / 2)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                let threshold: CGFloat = 50
                                let direction = value.translation.width
                                
                                if direction < -threshold, selectedIndex < items.count - 1 {
                                    selectedIndex += 1
                                } else if direction > threshold, selectedIndex > 0 {
                                    selectedIndex -= 1
                                }
                                
                                withAnimation {
                                    scrollProxy.scrollTo(selectedIndex, anchor: .center)
                                }
                            }
                    )
                    .onChange(of: selectedIndex) { newIndex in
                        withAnimation {
                            scrollProxy.scrollTo(newIndex, anchor: .center)
                        }
                    }
                }
            }
        }
        .frame(height: 250)
    }
}

struct SmoothCarouselView: View {
    let items = ["SwiftUI Carousel", "Short Text", "A very long text that should be trimmed", "Centered Item", "Another Item"]
    
    @State private var selectedIndex: Int = 0
    @Namespace private var scrollSpace
    
    var body: some View {
        GeometryReader { geometry in
            let cardWidth = geometry.size.width * 0.4
            let spacing: CGFloat = 15
            let dragThreshold: CGFloat = 100
            
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { scrollProxy in
                    HStack(spacing: spacing) {
                        ForEach(items.indices, id: \.self) { index in
                            let isSelected = selectedIndex == index
                            
                            Text(String(items[index].prefix(20)))
                                .font(.headline)
                                .frame(width: cardWidth, height: 40)
                                .background(isSelected ? Color.blue.opacity(0.8) : Color.gray.opacity(0.3))
                                .cornerRadius(15)
                                .shadow(radius: isSelected ? 12 : 5)
                                .scaleEffect(isSelected ? 1.1 : 1.0)
                                .animation(.interpolatingSpring(stiffness: 150, damping: 15), value: selectedIndex)
                                .id(index)
                        }
                    }
                    .padding(.horizontal, (geometry.size.width - cardWidth) / 2 - spacing / 2)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                let direction = value.translation.width
                                
                                if direction < -dragThreshold, selectedIndex < items.count - 1 {
                                    selectedIndex += 1
                                } else if direction > dragThreshold, selectedIndex > 0 {
                                    selectedIndex -= 1
                                }
                                
                                withAnimation(.interpolatingSpring(stiffness: 150, damping: 15)) {
                                    scrollProxy.scrollTo(selectedIndex, anchor: .center)
                                }
                            }
                    )
                    .onAppear {
                        DispatchQueue.main.async {
                            withAnimation {
                                scrollProxy.scrollTo(selectedIndex, anchor: .center)
                            }
                        }
                    }
                }
            }
        }
        .frame(height: 250)
    }
}
