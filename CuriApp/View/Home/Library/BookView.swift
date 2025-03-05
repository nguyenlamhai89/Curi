//
//  BookView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 5/3/25.
//

import SwiftUI

struct BookView: View {
    var body: some View {
        VStack {
            // Navigation
            TopNavigationBook()
            
            // Book conent
            VStack {
                Text("Headline")
                Text("Content")
            }
            .frame(maxHeight: .infinity)
            
            // Highlight
            HighlighDial()
            .frame(height: 80)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, curiSpacing(.sp16))
        }
        .background(curiPalette(.paper500))
    }
}

#Preview {
    BookView()
}
