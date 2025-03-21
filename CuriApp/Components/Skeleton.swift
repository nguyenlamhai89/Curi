//
//  SkeletonLoading.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 21/3/25.
//

import SwiftUI

struct SkeletonBlock: View {
    @State var isLoading: Bool = true
    @State var startX: CGFloat = -1
    @State var endX: CGFloat = 0
    
    var loadingState: Bool
//    var width: CGFloat
//    var height: CGFloat

    var body: some View {
        LinearGradient(colors: [curiPalette(.paper500), curiPalette(.paper300), curiPalette(.paper500)], startPoint: UnitPoint(x: startX, y: 0.5), endPoint: UnitPoint(x: endX, y: 0.5))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(8)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                    startX = 1.5
                    endX = 2.5
                }
            }
    }
}


struct AsyncLoadingView: View {
    @State var isLoading: Bool = true
    var body: some View {
        if isLoading {
            SkeletonBlock(loadingState: isLoading)
                .frame(width: 80, height: 80)
                .task {
                    try? await Task.sleep(for: .seconds(5))
                    isLoading = false
                }
        } else {
            Text("Loaded")
        }
    }
}

#Preview {
    AsyncLoadingView()
}
