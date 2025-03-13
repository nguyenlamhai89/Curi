//
//  HomeView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

struct LibraryView: View {
    // Binding from HomeView
    var books: [String]
    var authors: [String]
    var bookNameInBanner: String
    var authorNameInBanner: String
    @Binding var nameHighlightPrimary: String
    @Binding var nameHighlightSecondary: String
    var placeholderHighlightName: String
    @Binding var renameHighlightPrimaryView: Bool
    @Binding var renameHighlightSecondaryView: Bool
    var bookName: String
    
    var body: some View {
        ScrollView {
            VStack (spacing: curiSpacing(.sp20)) {
                Banner(bookNameInBanner: bookNameInBanner,
                       authorNameInBanner: authorNameInBanner,
                       nameHighlightPrimary: $nameHighlightPrimary,
                       nameHighlightSecondary: $nameHighlightSecondary,
                       placeholderHighlightName: placeholderHighlightName,
                       renameHighlightPrimaryView: $renameHighlightPrimaryView,
                       renameHighlightSecondaryView: $renameHighlightSecondaryView,
                       bookName: bookName)
                
                /// Book List
                VStack (alignment: .leading, spacing: curiSpacing(.sp8)) {
                    Text("For You")
                        .curiTypo(.sfMedium14)
                        .foregroundStyle(curiPalette(.ink300))

                    VStack {
//                        ForEach(Array(zip(books, authors)), id: \.0) { book, author in
//                            NavigationLink {
//                                BookView(autoFocusRename: false, nameHighlightPrimary: $nameHighlightPrimary, nameHighlightSecondary: $nameHighlightSecondary, placeholderHighlightName: placeholderHighlightName, renameHighlightPrimaryView: $renameHighlightPrimaryView, renameHighlightSecondaryView: $renameHighlightSecondaryView, bookName: bookName)
//                            } label: {
//                                BookAuthorCard(bookName: "\(book)", authorName: "\(author)")
//                            }
//                        }
                        ForEach(Array(zip(books, authors)), id: \.0) { book, author in
                            NavigationLink {
                                Text("Hi")
                            } label: {
                                BookAuthorCard(bookName: "\(book)", authorName: "\(author)")
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

            }
            .padding(.top, 80)
            .padding(.horizontal, curiSpacing(.sp16))
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    LibraryView(books: ["Hi", "Bar", "Mot"], authors: ["Ben", "Will", "Coulson"], bookNameInBanner: "Harry Potter", authorNameInBanner: "J. K. Rowling", nameHighlightPrimary: .constant("Discuss Later"), nameHighlightSecondary: .constant("Good Point"), placeholderHighlightName: "Name your highlight", renameHighlightPrimaryView: .constant(false), renameHighlightSecondaryView: .constant(false), bookName: "Harry Pọt tơ")
}
