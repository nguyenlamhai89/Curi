//
//  QuoteConnectView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 4/3/25.
//

import SwiftUI
import SwiftData

struct QuoteConnectView: View {
    @ObservedObject var bookViewModel: BookViewModel
    @State var searchLinkQuote: String = ""
    @State var connectedQuote: Int = 0
    
    /// Empty State - Search
    var emptySearchImage: String = "curiSearchEmpty"
    var emptySearchHeadline: String = "Looks like nothing matches — yet"
    var emptySearchParagraph: String = "Try refining your search — or highlight something new that sparks your mind"
    
    /// Empty State - Connectable Quote
    var emptyConnectImage: String = "curiConnectEmpty"
    var emptyConnectHeadline: String = "One quote alone can’t make a bridge"
    var emptyConnectParagraph: String = "Why not dive back into a book and mark one more moment that moves you?"
    
    @Query(sort: \Quote.quoteAddedDate, order: .reverse) var quoteDatabase: [Quote]
    
    var searchFilteredQuote: [Quote] {
        if searchLinkQuote.isEmpty {
            return quoteDatabase.filter { $0.quoteID != quote.quoteID }
        } else {
            return quoteDatabase.filter {
                $0.quoteID != quote.quoteID &&
                $0.quoteContent.localizedCaseInsensitiveContains(searchLinkQuote)
            }
        }
    }
    
    @Query var pencilDatabase: [HighlightPencil]
    @Bindable var quote: Quote
    
    var body: some View {
        Group {
            if quoteDatabase.filter({ $0.quoteID != quote.quoteID }).isEmpty {
                EmptyStateDescription(image: emptyConnectImage, headline: emptyConnectHeadline, paragraph: emptyConnectParagraph)
            } else if searchFilteredQuote.isEmpty {
                EmptyStateDescription(image: emptySearchImage, headline: emptySearchHeadline, paragraph: emptySearchParagraph)
            } else {
                ScrollView {
                    VStack (spacing: curiSpacing(.sp16)) {
                        ForEach(searchFilteredQuote) { quoteConnecting in
                            QuoteCardWithCheckbox(bookViewModel: bookViewModel, bookName: quoteConnecting.quoteBook, authorName: quoteConnecting.quoteAuthor, quoteContent: quoteConnecting.quoteContent, highlightTagName: quoteConnecting.quoteHighlight.name, highlightTagColor: quoteConnecting.quoteHighlight.primaryBackgroundColor, isConnected: quoteConnecting.isConnected, action: {
                                
                                if quote.connectedQuotes?.contains(where: { $0.quoteID == quoteConnecting.quoteID }) == false {
                                    quoteConnecting.isConnected = true
                                    quote.connectedQuotes?.append(quoteConnecting)
                                    print("[\(quoteConnecting.isConnected ? "✅" : "🙅🏼")] ID: \(quoteConnecting.quoteID) - Quote: \(quoteConnecting.quoteContent) - Connected: \(quoteConnecting.isConnected)")
                                } else {
                                    quoteConnecting.isConnected = false
                                    quote.connectedQuotes?.removeAll(where: { $0.quoteID == quoteConnecting.quoteID })
                                    print("[\(quoteConnecting.isConnected ? "✅" : "🙅🏼")] ID: \(quoteConnecting.quoteID) - Quote: \(quoteConnecting.quoteContent) - Connected: \(quoteConnecting.isConnected)")
                                }
                                
                            })
                        }
                    }
                }
                
            }
        }
        .navigationTitle("Connected (\(quote.connectedQuotes?.count ?? 0))")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchLinkQuote, placement:.navigationBarDrawer(displayMode: .always))
        .padding(.horizontal, curiSpacing(.sp16))
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(curiPalette(.paper500))
        .onAppear {
            print("🔗 This quote is connecting with: \(String(describing: quote.connectedQuotes))")
        }
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = true
    @Previewable @StateObject var bookViewModel = BookViewModel()
    VStack {
        Text("Test")
    }
    .sheet(isPresented: $isPresented) {
        NavigationView {
            QuoteConnectView(bookViewModel: bookViewModel, quote: Quote(bookID: UUID(), quoteBook: "Hi", quoteAuthor: "Hi", quoteContent: "Bar", quoteHighlight: HighlightPencil(name: "Discuss Later", primaryTextColor: "paper-500", primaryBackgroundColor: "blue-300", secondaryTextColor: "blue-500", secondaryBackgroundColor: "blue-100", highlightedTextColor: "blue-500", defaultHighlightedBackgroundColor: "blue-100", selectedHighlightedBackgroundColor: "blue-200")))
        }
    }
}
