//
//  LibraryErrorView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI

struct EmptyStateDescription: View {
    var image: String
    var headline: String
    var paragraph: String
    
    var body: some View {
        VStack (spacing: curiSpacing(.sp8)) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 80)
            Text("\(headline)")
                .curiTypo(.bkBold16)
                .foregroundStyle(curiPalette(.ink500))
            Text("\(paragraph)")
                .curiTypo(.sfMedium14)
                .foregroundStyle(curiPalette(.ink300))
        }
        .multilineTextAlignment(.center)
        .lineLimit(2)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct LibraryErrorView: View {
    @ObservedObject var bookViewModel: BookViewModel
    
    /// Empty State
    var emptyBookImage: String = "curiBookEmpty"
    var emptyBookHeadline: String = "Some things broke, but don’t dismay"
    var emptyBookParagraph: String = "We’ll patch it up — then you can play"
    
    var body: some View {
        VStack (spacing: curiSpacing(.sp16)) {
            EmptyStateDescription(image: emptyBookImage, headline: emptyBookHeadline, paragraph: emptyBookParagraph)
            TextButtonStroke(bookViewModel: bookViewModel, content: "Try Again", action: {
                Task {
                    try? await bookViewModel.fetchBooks()
                }
                print("Try again")
            })

        }
        .padding(.horizontal, curiSpacing(.sp16))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    @Previewable @StateObject var bookViewModel = BookViewModel()
    LibraryErrorView(bookViewModel: bookViewModel)
}
