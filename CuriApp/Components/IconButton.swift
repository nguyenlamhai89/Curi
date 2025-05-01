//
//  IconButton.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 27/2/25.
//

import SwiftUI

struct IconButton: View {
    @ObservedObject var bookViewModel: BookViewModel
    var iconName: String
    var hasNote: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
            SoundManager.access.play(sound: .iconButton, soundEnabledInApp: bookViewModel.soundInApp)
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
    @Previewable @StateObject var bookViewModel = BookViewModel()
    IconButton(bookViewModel: bookViewModel, iconName: "curiThought", hasNote: true) {
        print("Icon Button!")
    }
}
