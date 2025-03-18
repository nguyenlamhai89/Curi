//
//  TextButton.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 28/2/25.
//

import SwiftUI

struct TextButtonPlain: View {
    var content: String
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light)
            action()
        } label: {
            Text(content)
                .curiTypo(.sfMedium14)
                .foregroundStyle(curiPalette(.ink300))
                .frame(maxWidth: .infinity)
                .padding(.vertical, curiSpacing(.sp4))
        }
    }
}

struct TextButtonFilled: View {
    var content: String
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light)
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

struct TextButtonFilledIcon: View {
    var content: String
    var icon: String
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light)
            action()
        } label: {
            HStack (spacing: curiSpacing(.sp4)) {
                Text(content)
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
            }
                .curiTypo(.sfMedium14)
                .foregroundStyle(curiPalette(.ink500))
                .frame(maxWidth: .infinity)
                .padding(.vertical, curiSpacing(.sp4))
                .background(
                    RoundedRectangle(cornerRadius: curiRadius(.rdMax))
                        .stroke(curiPalette(.ink100), lineWidth: 1)
                )
                .cornerRadius(curiRadius(.rdMax))
        }
    }
}

struct TextButtonStroke: View {
    var content: String
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light)
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
    TextButtonPlain(content: "Plain", action: {
        print("Plain")
    })
    TextButtonFilled(content: "Filled", action: {
        print("Filled")
    })
    TextButtonFilledIcon(content: "Filled with Icon", icon: "curiBook", action: {
        print("Filled with Icon")
    })
    TextButtonStroke(content: "Stroke", action: {
        print("Stroke")
    })
}
