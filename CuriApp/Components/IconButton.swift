//
//  IconButton.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 27/2/25.
//

import SwiftUI

struct IconButton: View {
    var iconName: String
    var hasNote: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light)
            SoundManager.access.play(sound: .iconButton)
            action()
        } label: {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 24)
                .padding(curiSpacing(.sp4))
                .background(hasNote ? curiPalette(.ink300) : curiPalette(.ink100))
                .cornerRadius(curiRadius(.rdMax))
        }
    }
}

#Preview {
    IconButton(iconName: "curiThought", hasNote: true) {
        print("Icon Button!")
    }
}
