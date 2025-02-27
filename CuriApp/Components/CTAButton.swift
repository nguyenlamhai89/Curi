//
//  CTAButton.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 27/2/25.
//

import SwiftUI

struct CTAButtonPrimary: View {
    var content: String
    
    var body: some View {
        Text(content)
            .curiTypo(.sfRegular16)
            .foregroundStyle(curiPalette(.paper500))
            .padding(curiSpacing(.sp12))
            .frame(maxWidth: .infinity)
            .background(curiPalette(.ink500))
            .cornerRadius(curiSpacing(.sp20))
    }
}

struct CTAButtonSecondary: View {
    var content: String
    
    var body: some View {
        Text(content)
            .curiTypo(.sfRegular16)
            .foregroundStyle(curiPalette(.ink500))
            .padding(curiSpacing(.sp12))
            .frame(maxWidth: .infinity)
            .background(curiPalette(.paper300))
            .cornerRadius(curiSpacing(.sp20))
    }
}

#Preview {
    VStack (spacing: 16) {
        CTAButtonPrimary(content: "Primary")
        CTAButtonSecondary(content: "Secondary")
    }
    .padding(16)
}
