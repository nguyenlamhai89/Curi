//
//  LinkButton.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/5/25.
//

import SwiftUI

struct LinkButton: View {
    @Environment(\.openURL) private var openURL
    @ObservedObject var bookViewModel: BookViewModel
    
    var buttonName: String
    var urlString: String
    
    var body: some View {
        Button {
//            if bookViewModel.vibrationInApp {
//                HapticsManager.access.play(haptics: .light)
//            }
            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
            if let url = URL(string: urlString) {
                openURL(url)
            }
        } label: {
            Text(buttonName)
                .curiTypo(.bkRegular14)
                .foregroundStyle(curiPalette(.ink500))
                .padding(.vertical, curiSpacing(.sp8))
                .frame(maxWidth: .infinity, alignment: .leading)
        }

    }
}

#Preview {
    @Previewable @StateObject var bookViewModel = BookViewModel()
    LinkButton(bookViewModel: bookViewModel, buttonName: "Music by Thomas William", urlString: "https://www.thomaswilliams-sound.com")
}
