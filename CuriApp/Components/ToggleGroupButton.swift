//
//  ToggleGroupButton.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/5/25.
//

import SwiftUI

struct ToggleGroupButton: View {
    @Binding var isOn: Bool
    var buttonImage: String
    var buttonName: String
    var buttonDescription: String
    var body: some View {
        Toggle(isOn: $isOn) {
            HStack (spacing: curiSpacing(.sp8)) {
                Image(buttonImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
                VStack (alignment: .leading, spacing: -4) {
                    Text(buttonName)
                        .curiTypo(.bkRegular14)
                        .foregroundStyle(curiPalette(.ink500))
                    Text(buttonDescription)
                        .curiTypo(.bkRegular12)
                        .foregroundStyle(curiPalette(.ink300))
                }
            }
        }
        .tint(curiPalette(.blue300))
    }
}

#Preview {
    ToggleGroupButton(isOn: .constant(false), buttonImage: "curiLogo", buttonName: "Sound", buttonDescription: "While adding or removing a highlight")
    ToggleGroupButton(isOn: .constant(true), buttonImage: "curiLogo", buttonName: "Vibration", buttonDescription: "While interacting with buttons")
}
