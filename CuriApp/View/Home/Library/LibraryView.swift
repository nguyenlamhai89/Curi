//
//  HomeView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

struct LibraryView: View {
    @Bindable var bookViewModel: BookViewModel
    
//    @State var isLoading: Bool = true
    @State var bookNavigate: Bool = false
    
    // Binding from HomeView
    var bookNameInBanner: String
    var authorNameInBanner: String
//    @Binding var nameHighlightPrimary: String
//    @Binding var nameHighlightSecondary: String
    var placeholderHighlightName: String
//    @Binding var renameViewPrimary: Bool
//    @Binding var renameViewSecondary: Bool
//    var bookNameAtNavigationForEach: String
    
//    @State var fetchedError: Bool = false
    
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
                        let bookIDSample = UUID()
                        BookView(bookViewModel: bookViewModel, bookID: bookIDSample, bookTitle: "Feature Book Name", bookAuthor: "Shakespeare", bookLinesOriginal: ["Sample", "Book", "Lines"], placeholderHighlightName: placeholderHighlightName)
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

                    LazyVStack {
                        ForEach(bookViewModel.bookDatabase) { book in
                            NavigationLink {
//                                BookView(bookViewModel: bookViewModel, bookID: book.id, bookTitle: book.title, bookAuthor: book.author, bookLinesOriginal: book.lines, nameHighlightPrimary: $nameHighlightPrimary, nameHighlightSecondary: $nameHighlightSecondary, placeholderHighlightName: placeholderHighlightName, renameHighlightPrimaryView: $renameViewPrimary, renameHighlightSecondaryView: $renameViewSecondary)
                                BookView(bookViewModel: bookViewModel, bookID: book.id, bookTitle: book.title, bookAuthor: book.author, bookLinesOriginal: book.lines, placeholderHighlightName: placeholderHighlightName)
                            } label: {
                                BookAuthorCard(bookName: "\(book.title)", authorName: "\(book.author)")
                            }
                            .onAppear {
                                print("\(book.id)")
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
            .padding(.top, 80)
            .padding(.horizontal, curiSpacing(.sp16))
        }
        .scrollIndicators(.hidden)
        .onAppear {
            print("Selected Pen: \(bookViewModel.selectedPen?.name)")
        }
    }
}



//#Preview {
//    @Previewable @Bindable var bookViewModel = BookViewModel()
//    LibraryView(bookViewModel: bookViewModel, bookNameInBanner: "Sonnet", authorNameInBanner: "William Shakespeare", placeholderHighlightName: "Your highlight name", renameViewPrimary: .constant(false), renameViewSecondary: .constant(false))
//}
