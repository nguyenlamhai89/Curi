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
            VStack (alignment: .leading) {
                Text("Book \(bookName)")
                    .curiTypo(.sfMedium32)
                    .foregroundStyle(curiPalette(.ink500))
                    .lineLimit(2)
                Text("Author \(authorName)")
                    .curiTypo(.sfRegular16)
                    .foregroundStyle(curiPalette(.ink300))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
                .background(curiPalette(.ink100))
        }
    }
}

#Preview {
    ForEach(0..<4) { _ in
        BookAuthorCard(bookName: "Not at Home to Callers", authorName: "Emily Dickinson")
            
    }
    .padding(.horizontal, 16)
}
