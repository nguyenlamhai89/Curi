//
//  TextButton.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 28/2/25.
//

import SwiftUI

struct TextButtonPlain: View {
    @ObservedObject var bookViewModel: BookViewModel
    var content: String
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
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
    @ObservedObject var bookViewModel: BookViewModel
    var content: String
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
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
    @ObservedObject var bookViewModel: BookViewModel
    var content: String
    var icon: String
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
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

struct TextButtonFilledNumber: View {
    @ObservedObject var bookViewModel: BookViewModel
    var content: String
    var icon: String
    var connectedNumber: Int
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
            action()
        } label: {
            HStack (spacing: curiSpacing(.sp4)) {
                Text(content)
                Image(connectedNumber > 0 ? "curiNumber" : icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                    .overlay {
                        if connectedNumber > 0 {
                            Text("\(connectedNumber)")
                                .curiTypo(.sfMedium12)
                                .foregroundStyle(curiPalette(.ink500))
                                .multilineTextAlignment(.center)
                        } else {
                            EmptyView()
                        }
                    }
            }
                .curiTypo(.sfMedium14)
                .foregroundStyle(connectedNumber > 0 ? curiPalette(.paper500) : curiPalette(.ink500))
                .frame(maxWidth: .infinity)
                .padding(.vertical, curiSpacing(.sp4))
                .background(
                    RoundedRectangle(cornerRadius: curiRadius(.rdMax))
                        .fill(connectedNumber > 0 ? curiPalette(.ink500) : Color.clear)
                        .stroke(connectedNumber > 0 ? Color.clear : curiPalette(.ink100), lineWidth: 1)
                )
                .cornerRadius(curiRadius(.rdMax))
        }
    }
}

struct TextButtonStroke: View {
    @ObservedObject var bookViewModel: BookViewModel
    var content: String
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
            action()
        } label: {
            Text(content)
                .curiTypo(.sfMedium14)
                .foregroundStyle(curiPalette(.ink500))
                .padding(.vertical, curiSpacing(.sp4))
                .padding(.horizontal, curiSpacing(.sp16))
                .background(
                    RoundedRectangle(cornerRadius: curiRadius(.rdMax))
                        .stroke(curiPalette(.ink100), lineWidth: 1)
                )
                .cornerRadius(curiRadius(.rdMax))
        }
    }
}

#Preview {
    @Previewable @StateObject var bookViewModel = BookViewModel()
    TextButtonPlain(bookViewModel: bookViewModel, content: "Plain", action: {
        print("Plain")
    })
    TextButtonFilled(bookViewModel: bookViewModel, content: "Filled", action: {
        print("Filled")
    })
    TextButtonFilledIcon(bookViewModel: bookViewModel, content: "Filled with Icon", icon: "curiBook", action: {
        print("Filled with Icon")
    })
    TextButtonStroke(bookViewModel: bookViewModel, content: "Stroke", action: {
        print("Stroke")
    })
    
    TextButtonFilledNumber(bookViewModel: bookViewModel, content: "Filled Number", icon: "curiNumber", connectedNumber: 0) {
        print("Number")
    }
    
    TextButtonFilledNumber(bookViewModel: bookViewModel, content: "Filled Number", icon: "curiNumber", connectedNumber: 4) {
        print("Number")
    }
    
    TextButtonFilledNumber(bookViewModel: bookViewModel, content: "Filled Number", icon: "curiNumber", connectedNumber: 16) {
        print("Number")
    }
}
