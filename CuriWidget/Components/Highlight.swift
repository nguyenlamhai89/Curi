//
//  Highlight.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 3/3/25.
//

import SwiftUI

struct HighlightTag: View {
    var content: String
    var color: Color
    
    var body: some View {
        Text("\(content)")
            .curiTypo(.sfMedium14)
            .foregroundStyle(curiPalette(.paper500))
            .padding(.vertical, curiSpacing(.sp2))
            .padding(.horizontal, curiSpacing(.sp8))
            .background(color)
            .cornerRadius(curiRadius(.rd4))
//            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    @Previewable @State var tagNameDemoBlue: String = "Discuss Later"
    
    HighlightTag(content: tagNameDemoBlue, color: Color.cyan)
}
