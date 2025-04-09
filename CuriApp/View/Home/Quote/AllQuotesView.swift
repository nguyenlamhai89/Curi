//
//  SearchSheetView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI
import SwiftData

struct IdentifiableHighlight: Identifiable {
    var id = UUID()
    var book: String
    var author: String
    var lines: String
}

struct AllQuotesView: View {
    @State var searchAvailableQuote: String = ""
    @Binding var quoteCardisPresented: Bool
    
    @Bindable var bookViewModel: BookViewModel
    @Query var quoteDatabase: [Quote]
    @State var itemSelected: IdentifiableHighlight?
    
    var emptyHeadline: String = "No quotes yet, but that’s okay,"
    var emptyParagraph: String = "Start with a book, and mark your way!"
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack (spacing: curiSpacing(.sp16)) {
                        ForEach(quoteDatabase) { quote in
                            QuoteCard(
                                bookName: quote.quoteBook, authorName: quote.quoteAuthor, quoteContent: "\(quote.quoteContent)", highlightTagName: "Discuss Later", action: {
                                    self.itemSelected = IdentifiableHighlight(book: quote.quoteBook, author: quote.quoteAuthor, lines: quote.quoteContent)
                                    self.quoteCardisPresented.toggle()
                                    print("HAINL self.itemSelected \(String(describing: self.itemSelected))")
                                }
                            )
                            //                                .sheet(isPresented: $quoteCardisPresented, content: {
                            //                                    QuoteNoteSheetView(bookViewModel: bookViewModel, quote: quote.quoteContent, author: quote.quoteAuthor, book: quote.quoteBook)
                            //                                })
                            .sheet(item: $itemSelected) { quoteSelected in
                                QuoteNoteSheetView(bookViewModel: bookViewModel, quote: quoteSelected.quoteContent, author: quoteSelected.quoteAuthor, book: quoteSelected.quoteBook)
                            }
                        }
                    }
                }
            }
            .navigationTitle("All Quotes (\(quoteDatabase.count))")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal, curiSpacing(.sp16))
            .frame(maxWidth: .infinity)
            .scrollIndicators(.hidden)
            .searchable(text: $searchAvailableQuote, placement:.navigationBarDrawer(displayMode: .always), prompt: "Search Your Quote")
            
        }
        .background(curiPalette(.paper500))
    }
}

#Preview {
    @Previewable @Bindable var bookViewModel = BookViewModel()
    @Previewable @State var quoteCardisPresented: Bool = false
    AllQuotesView(quoteCardisPresented: $quoteCardisPresented, bookViewModel: bookViewModel)
}
