//
//  CTAButton.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 27/2/25.
//

import SwiftUI

struct CTAButtonPrimary: View {
    @ObservedObject var bookViewModel: BookViewModel
    var content: String
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .heavy, vibrationEnabledInApp: bookViewModel.vibrationInApp)
            action()
        } label: {
            Text(content)
                .curiTypo(.sfRegular16)
                .foregroundStyle(curiPalette(.paper500))
                .padding(curiSpacing(.sp12))
                .frame(maxWidth: .infinity)
                .background(curiPalette(.ink500))
                .cornerRadius(curiRadius(.rdMax))
        }

    }
}

struct CTAButtonSecondary: View {
    @ObservedObject var bookViewModel: BookViewModel
    var content: String
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .heavy, vibrationEnabledInApp: bookViewModel.vibrationInApp)
            action()
        } label: {
            Text(content)
                .curiTypo(.sfRegular16)
                .foregroundStyle(curiPalette(.ink500))
                .padding(curiSpacing(.sp12))
                .frame(maxWidth: .infinity)
                .background(curiPalette(.paper300))
                .cornerRadius(curiRadius(.rdMax))
        }

    }
}

#Preview {
    @Previewable @StateObject var bookViewModel = BookViewModel()
    VStack (spacing: 16) {
        CTAButtonPrimary(bookViewModel: bookViewModel, content: "Primary", action: {
            print("Primary")
        })
        CTAButtonSecondary(bookViewModel: bookViewModel, content: "Secondary", action: {
            print("Secondary")
        })
    }
    .padding(16)
}
