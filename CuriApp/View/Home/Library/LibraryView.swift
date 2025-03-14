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
    var bookNameAtNavigation: String
    
    var body: some View {
        ScrollView {
            VStack (spacing: curiSpacing(.sp20)) {
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
                        BookView(nameHighlightPrimary: $nameHighlightPrimary, nameHighlightSecondary: $nameHighlightSecondary, placeholderHighlightName: placeholderHighlightName, renameHighlightPrimaryView: $renameHighlightPrimaryView, renameHighlightSecondaryView: $renameHighlightSecondaryView, bookNameAtNavigation: bookNameInBanner)
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
                        ForEach(bookViewModel.books) { book in
                            Text("\(book.title)")
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
//    LibraryView(bookViewModel: BookViewModel, bookNameInBanner: <#T##String#>, authorNameInBanner: <#T##String#>, nameHighlightPrimary: <#T##String#>, nameHighlightSecondary: <#T##String#>, placeholderHighlightName: <#T##String#>, renameHighlightPrimaryView: <#T##Bool#>, renameHighlightSecondaryView: <#T##Bool#>, bookName: <#T##String#>)
//}
