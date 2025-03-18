//
//  Haptics.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 18/3/25.
//

import SwiftUI

class HapticsManager {
    static let access = HapticsManager()
    
    enum HapticsCase {
        case light, heavy
        
        func trigger() {
            switch self {
            case .light:
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            case .heavy:
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            }
        }
    }
    
    func play(haptics: HapticsCase) {
        haptics.trigger()
    }
}

struct Haptics: View {
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light)
        } label: {
            Text("Play Haptics")
        }

    }
}

#Preview {
    Haptics()
}
