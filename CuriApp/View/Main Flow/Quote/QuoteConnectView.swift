//
//  QuoteConnectView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 4/3/25.
//

import SwiftUI
import SwiftData

struct QuoteConnectView: View {
    /// SwiftData
    @Query(sort: \Quote.quoteAddedDate, order: .reverse) var quoteDatabase: [Quote]
    @Query var pencilDatabase: [HighlightPencil]
    
    /// Local View
    @Bindable var quote: Quote
    @ObservedObject var bookViewModel: BookViewModel
    @State var searchLinkQuote: String = ""
    @State var connectedQuote: Int = 0
    var emptySearchImage: String = "curiSearchEmpty"
    var emptySearchHeadline: String = "Looks like nothing matches — yet"
    var emptySearchParagraph: String = "Try refining your search — or highlight something new that sparks your mind"
    var emptyConnectImage: String = "curiConnectEmpty"
    var emptyConnectHeadline: String = "One quote alone can’t make a bridge"
    var emptyConnectParagraph: String = "Why not dive back into a book and mark one more moment that moves you?"
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
                            
                            let isConnected = quoteConnecting.connectedQuotes?.contains(where: { $0.quoteID == quote.quoteID }) == true
                            
                            QuoteCardWithCheckbox(bookViewModel: bookViewModel, bookName: quoteConnecting.quoteBook, authorName: quoteConnecting.quoteAuthor, quoteContent: quoteConnecting.quoteContent, highlightTagName: quoteConnecting.quoteHighlight?.name ?? "", highlightTagColor: quoteConnecting.quoteHighlight?.primaryBackgroundColor ?? "", isConnected: isConnected, action: {
                                
                                if isConnected {
                                    quote.connectedQuotes?.removeAll(where: { $0.quoteID == quoteConnecting.quoteID })
                                    quoteConnecting.connectedQuotes?.removeAll(where: { $0.quoteID == quote.quoteID })
                                } else {
                                    quote.connectedQuotes?.append(quoteConnecting)
                                    quoteConnecting.connectedQuotes?.append(quote)
                                }
                                
                                print("[\(quote.isConnected ? "✅" : "🙅🏼")] - \(quote.quoteAddedDate) Connected With: \(String(describing: quote.connectedQuotes))")
                                print("[\(quoteConnecting.isConnected ? "✅" : "🙅🏼")] - \(quoteConnecting.quoteAddedDate) - Connected With: \(String(describing: quoteConnecting.connectedQuotes))")
                                
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
            QuoteConnectView(bookViewModel: bookViewModel, quote: Quote(quoteID: UUID(), quoteLineNum: 0, quoteAddedDate: Date(), quoteBook: "Hi", quoteAuthor: "Hi", quoteContent: "Bar", quoteHighlight: HighlightPencil(name: "Discuss Later", primaryTextColor: "paper-500", primaryBackgroundColor: "blue-300", isPresentedRenameView: false, secondaryTextColor: "blue-500", secondaryBackgroundColor: "blue-100", highlightedTextColor: "blue-500", defaultHighlightedBackgroundColor: "blue-100", selectedHighlightedBackgroundColor: "blue-200"), isConnected: false, quoteNote: Note(noteContent: "")))
//            QuoteConnectView(bookViewModel: bookViewModel, quote: Quote())
        }
    }
}
