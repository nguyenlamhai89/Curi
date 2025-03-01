//
//  TextButton.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 28/2/25.
//

import SwiftUI

struct TextButtonFilled: View {
    var content: String
    var action: () -> Void
    
    var body: some View {
        Button {
            let impactFeedback = UIImpactFeedbackGenerator(style: .light)
            impactFeedback.impactOccurred()
            action()
        } label: {
            Text(content)
                .curiTypo(.sfMedium14)
                .foregroundStyle(curiPalette(.ink500))
                .padding(.vertical, curiSpacing(.sp4))
                .padding(.horizontal, curiSpacing(.sp8))
                .background(curiPalette(.paper500))
                .cornerRadius(curiRadius(.rdMax))
        }
    }
}

struct TextButtonStroke: View {
    var content: String
    var action: () -> Void
    
    var body: some View {
        Button {
            let impactFeedback = UIImpactFeedbackGenerator(style: .light)
            impactFeedback.impactOccurred()
            action()
        } label: {
            Text(content)
                .curiTypo(.sfMedium14)
                .foregroundStyle(curiPalette(.ink500))
                .padding(.vertical, curiSpacing(.sp4))
                .padding(.horizontal, curiSpacing(.sp8))
                .background(
                    RoundedRectangle(cornerRadius: curiRadius(.rdMax))
                        .stroke(curiPalette(.ink100), lineWidth: 1)
                )
                .cornerRadius(curiRadius(.rdMax))
        }
    }
}

#Preview {
    TextButtonFilled(content: "Filled", action: {
        print("Filled")
    })
    TextButtonStroke(content: "Stroke", action: {
        print("Stroke")
    })
}
