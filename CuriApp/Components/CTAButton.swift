//
//  CTAButton.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 27/2/25.
//

import SwiftUI

struct CTAButtonPrimary: View {
    var content: String
    var action: () -> Void
    
    var body: some View {
        Button {
            let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
            impactFeedback.impactOccurred()
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
    var content: String
    var action: () -> Void
    
    var body: some View {
        Button {
            let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
            impactFeedback.impactOccurred()
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
    VStack (spacing: 16) {
        CTAButtonPrimary(content: "Primary", action: {
            print("Primary")
        })
        CTAButtonSecondary(content: "Secondary", action: {
            print("Secondary")
        })
    }
    .padding(16)
}
