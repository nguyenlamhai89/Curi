//
//  SkeletonLoading.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 21/3/25.
//

import SwiftUI

struct SkeletonBlock: View {
    @State var startX: CGFloat = -1
    @State var endX: CGFloat = 0
    
    var loadingState: Bool

    var body: some View {
        LinearGradient(colors: [curiPalette(.paper300), curiPalette(.paper500), curiPalette(.paper300)], startPoint: UnitPoint(x: startX, y: 0.5), endPoint: UnitPoint(x: endX, y: 0.5))
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
        RoundedRectangle(cornerRadius: 0)
            .fill(curiPalette(.paper500))
            .ignoresSafeArea()
            .overlay {
                if isLoading {
                    SkeletonBlock(loadingState: isLoading)
                        .frame(width: 200, height: 80)
                } else {
                    Text("Loaded")
                        .curiTypo(.bkRegular16)
                        .foregroundStyle(curiPalette(.ink500))
                }
            }
    }
}

#Preview {
    AsyncLoadingView()
}
