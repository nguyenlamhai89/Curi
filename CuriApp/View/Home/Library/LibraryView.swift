//
//  HomeView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var bookViewModel: BookViewModel
    
    @State var bookNavigate: Bool = false
    
    // Binding from HomeView
//    var books: [String]
//    var authors: [String]
    var bookNameInBanner: String
    var authorNameInBanner: String
    @Binding var nameHighlightPrimary: String
    @Binding var nameHighlightSecondary: String
    var placeholderHighlightName: String
    @Binding var renameHighlightPrimaryView: Bool
    @Binding var renameHighlightSecondaryView: Bool
    var bookNameAtNavigationForEach: String
    
    var body: some View {
        ScrollView {
            VStack (spacing: curiSpacing(.sp20)) {
                /// MARK - Banner
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
                        BookView(sampleBookChapter: "Feature Book Name", sampleBookContent: ["Sample", "Book", "Lines"], nameHighlightPrimary: $nameHighlightPrimary, nameHighlightSecondary: $nameHighlightSecondary, placeholderHighlightName: placeholderHighlightName, renameHighlightPrimaryView: $renameHighlightPrimaryView, renameHighlightSecondaryView: $renameHighlightSecondaryView, bookNameAtNavigationForEach: bookNameInBanner)
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
                
                /// MARK - Book List
                VStack (alignment: .leading, spacing: curiSpacing(.sp8)) {
                    Text("For You")
                        .curiTypo(.sfMedium14)
                        .foregroundStyle(curiPalette(.ink300))

                    VStack {
                        ForEach(bookViewModel.books) { book in
                            NavigationLink {
//                                Text("\(book.lines)")
                                BookView(sampleBookChapter: book.title, sampleBookContent: book.lines, nameHighlightPrimary: $nameHighlightPrimary, nameHighlightSecondary: $nameHighlightSecondary, placeholderHighlightName: placeholderHighlightName, renameHighlightPrimaryView: $renameHighlightPrimaryView, renameHighlightSecondaryView: $renameHighlightSecondaryView, bookNameAtNavigationForEach: bookNameAtNavigationForEach)
                            } label: {
                                BookAuthorCard(bookName: "\(book.title)", authorName: "\(book.author[0])")
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

//#Preview {
//    LibraryView(bookNameInBanner: "Harry Potter", authorNameInBanner: "J. K. Rowling", nameHighlightPrimary: .constant("Discuss Later"), nameHighlightSecondary: .constant("Good Point"), placeholderHighlightName: "Your highlight name", renameHighlightPrimaryView: .constant(false), renameHighlightSecondaryView: .constant(false), bookNameAtNavigationForEach: "Harry Potter")
//}
