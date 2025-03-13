//
//  Banner.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI

struct Banner: View {
    @State var bookNavigate: Bool = false
    
    // Binding from Homeview
    var bookNameInBanner: String
    var authorNameInBanner: String
    @Binding var nameHighlightPrimary: String
    @Binding var nameHighlightSecondary: String
    var placeholderHighlightName: String
    @Binding var renameHighlightPrimaryView: Bool
    @Binding var renameHighlightSecondaryView: Bool
    var bookName: String
    
    var body: some View {
        HStack (alignment: .bottom) {
            VStack (alignment: .leading, spacing: 0) {
                Text(bookNameInBanner)
                    .curiTypo(.sfMedium32)
                    .lineLimit(1)
                Text(authorNameInBanner)
                    .curiTypo(.sfMedium16)
                    .lineLimit(1)
            }
            .foregroundStyle(curiPalette(.paper500))
            .frame(maxWidth: .infinity, alignment: .leading)
            
            TextButtonFilled(content: "Read Now", action: {
                bookNavigate.toggle()
                print("Go to book")
            })
            .navigationDestination(isPresented: $bookNavigate) {
                BookView(nameHighlightPrimary: $nameHighlightPrimary, nameHighlightSecondary: $nameHighlightSecondary, placeholderHighlightName: placeholderHighlightName, renameHighlightPrimaryView: $renameHighlightPrimaryView, renameHighlightSecondaryView: $renameHighlightSecondaryView, bookName: bookName)
            }
        }
        .frame(height: 200, alignment: .bottomLeading)
        .frame(maxWidth: .infinity)
        .padding(curiSpacing(.sp16))
        .background(
            Image("curiBannerSample")
                .resizable()
                .scaledToFill()
        )
        .cornerRadius(curiRadius(.rd4))
    }
}

#Preview {
    Banner(bookNameInBanner: "Harry Potter", authorNameInBanner: "J. K. Rowling", nameHighlightPrimary: .constant("Discuss Later"), nameHighlightSecondary: .constant("Good Points"), placeholderHighlightName: "Your highlight", renameHighlightPrimaryView: .constant(false), renameHighlightSecondaryView: .constant(false), bookName: "Harry Potter")
        .padding(16)
}
