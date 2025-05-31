//
//  HomeView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

struct LibraryView: View {
    /// Local View
    @ObservedObject var bookViewModel: BookViewModel
    @State var bookNavigate: Bool = false
    var featuredBook: Book {
        bookViewModel.bookDatabase.first(where: { $0.title == "Winter" }) ?? Book(title: "Book not found!", author: "🦧", lines: ["Another", "Book Name", "Please 🥺.."])
    }
    
    var body: some View {
        ScrollView {
            VStack (spacing: curiSpacing(.sp20)) {
                /// MARK - Featured Book (Random)
                HStack (alignment: .bottom) {
                    VStack (alignment: .leading, spacing: 0) {
                        Text(featuredBook.title)
                            .curiTypo(.sfMedium32)
                            .lineLimit(1)
                        Text(featuredBook.author)
                            .curiTypo(.sfMedium16)
                            .lineLimit(1)
                    }
                    .foregroundStyle(curiPalette(.paper500))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextButtonFilled(bookViewModel: bookViewModel, content: "Read Now", action: {
                        bookNavigate.toggle()
                    })
                    .navigationDestination(isPresented: $bookNavigate) {
                        BookView(bookViewModel: bookViewModel, bookLinesOriginal: featuredBook.lines, bookID: UUID(), bookTitle: featuredBook.title, bookAuthor: featuredBook.author)
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
                                BookView(bookViewModel: bookViewModel, bookLinesOriginal: book.lines, bookID: book.id, bookTitle: book.title, bookAuthor: book.author)
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
            print("Selected Pen: \(bookViewModel.selectedPen?.name ?? "none")")
        }
    }
}


#Preview {
    @Previewable @StateObject var bookViewModel = BookViewModel()
    LibraryView(bookViewModel: bookViewModel)
}
