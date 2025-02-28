//
//  TextButton.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 28/2/25.
//

import SwiftUI

struct TextButtonFilled: View {
    var content: String
    
    var body: some View {
        Text(content)
            .curiTypo(.sfMedium14)
            .foregroundStyle(curiPalette(.ink500))
            .padding(.vertical, curiSpacing(.sp4))
            .padding(.horizontal, curiSpacing(.sp8))
            .background(curiPalette(.paper500))
            .cornerRadius(curiRadius(.rdMax))
    }
}

#Preview {
    TextButtonFilled(content: "Filled")
}
