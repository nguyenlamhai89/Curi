//
//  LibraryErrorView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI

struct LibraryErrorView: View {
    var body: some View {
        VStack (spacing: curiSpacing(.sp16)) {
            VStack (spacing: curiSpacing(.sp8)) {
                Text("We are fixing some troubles!")
                    .curiTypo(.bkBold16)
                    .foregroundStyle(curiPalette(.ink500))
                Text("Please wait for a moment, get some snacks and try again!")
                    .curiTypo(.sfMedium14)
                    .foregroundStyle(curiPalette(.ink300))
            }
            .multilineTextAlignment(.center)
            .lineLimit(2)
            
            Button {
                print("Try Again")
            } label: {
                TextButtonStroke(content: "Try Again")
            }

        }
        .frame(width: 240)
        .frame(maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    LibraryErrorView()
}
