//
//  BookAuthorCard.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 28/2/25.
//

import SwiftUI

struct BookAuthorCard: View {
    var bookName: String
    var authorName: String
    
    var body: some View {
        VStack (spacing: curiSpacing(.sp12)) {
            VStack (alignment: .leading, spacing: 0) {
                Text("\(bookName)")
                    .curiTypo(.sfMedium32)
                    .foregroundStyle(curiPalette(.ink500))
                    .lineLimit(2)
                    .padding(.horizontal, 0)
                    .multilineTextAlignment(.leading)
                Text("\(authorName)")
                    .curiTypo(.sfRegular16)
                    .foregroundStyle(curiPalette(.ink300))
                    .lineLimit(1)
                    .padding(.horizontal, 0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
                .background(curiPalette(.ink100))
        }
    }
}

#Preview {
    VStack {
        BookAuthorCard(bookName: "Sonnet 3: Look in thy glass and tell the face thou viewest", authorName: "Emily Dickinson")
        BookAuthorCard(bookName: "Sonnet 7: Lo! in the orient when the gracious light", authorName: "Emily Dickinson")
    }
    .padding(.horizontal, 16)
}
