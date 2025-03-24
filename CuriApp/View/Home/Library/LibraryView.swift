//
//  HomeView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var bookViewModel: BookViewModel
    
    @State var isLoadingBook: Bool = true
    @State var bookNavigate: Bool = false
    
    // Binding from HomeView
    var bookNameInBanner: String
    var authorNameInBanner: String
    @Binding var nameHighlightPrimary: String
    @Binding var nameHighlightSecondary: String
    var placeholderHighlightName: String
    @Binding var renameHighlightPrimaryView: Bool
    @Binding var renameHighlightSecondaryView: Bool
//    var bookNameAtNavigationForEach: String
    
    var body: some View {
        ScrollView {
            VStack (spacing: curiSpacing(.sp20)) {
                /// MARK - Banner
                if isLoadingBook {
                    SkeletonBlock(loadingState: isLoadingBook)
                        .frame(height: 232)
                } else {
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
                            BookView(bookTitle: "Feature Book Name", bookLines: ["Sample", "Book", "Lines"], nameHighlightPrimary: $nameHighlightPrimary, nameHighlightSecondary: $nameHighlightSecondary, placeholderHighlightName: placeholderHighlightName, renameHighlightPrimaryView: $renameHighlightPrimaryView, renameHighlightSecondaryView: $renameHighlightSecondaryView)
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
                
                /// MARK - Book List
                VStack (alignment: .leading, spacing: curiSpacing(.sp8)) {
                    if isLoadingBook {
                        SkeletonBlock(loadingState: isLoadingBook)
                            .frame(width: 100, height: 24)
                    } else {
                        Text("For You")
                            .curiTypo(.sfMedium14)
                            .foregroundStyle(curiPalette(.ink300))
                    }

                    LazyVStack {
                        if isLoadingBook {
                            ForEach(0..<10) { _ in
                                SkeletonBlock(loadingState: isLoadingBook)
                                    .frame(height: 80)
                            }
                        } else {
                            ForEach(bookViewModel.booksDatabase) { book in
                                NavigationLink {
                                    BookView(bookTitle: book.title, bookLines: book.lines, nameHighlightPrimary: $nameHighlightPrimary, nameHighlightSecondary: $nameHighlightSecondary, placeholderHighlightName: placeholderHighlightName, renameHighlightPrimaryView: $renameHighlightPrimaryView, renameHighlightSecondaryView: $renameHighlightSecondaryView)
                                        .environmentObject(bookViewModel)
                                } label: {
                                    BookAuthorCard(bookName: "\(book.title)", authorName: "\(book.author)")
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .task {
                    try? await bookViewModel.fetchBooks()
                    isLoadingBook = false
                    print("📚 \(bookViewModel.booksDatabase.count) is successfully loaded!")
                }
            }
            .padding(.top, 80)
            .padding(.horizontal, curiSpacing(.sp16))
        }
        .scrollIndicators(.hidden)
    }
}



//#Preview {
//    @Previewable @EnvironmentObject var bookViewModel: BookViewModel
//    LibraryView(bookNameInBanner: "Sonnet", authorNameInBanner: "William Shakespeare", nameHighlightPrimary: .constant("Discuss Later"), nameHighlightSecondary: .constant("Good Point"), placeholderHighlightName: "Your highlight name", renameHighlightPrimaryView: .constant(false), renameHighlightSecondaryView: .constant(false))
//}
