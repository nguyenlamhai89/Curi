//
//  QuoteConnectView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 4/3/25.
//

import SwiftUI
import SwiftData
import Mixpanel

struct QuoteConnectView: View {
    /// SwiftData
    @Query(sort: \Quote.quoteAddedDate, order: .reverse) var quoteDatabase: [Quote]
    @Query var pencilDatabase: [HighlightPencil]
    
    /// Local View
    @ObservedObject var bookViewModel: BookViewModel
    @Bindable var quote: Quote
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
                                bookViewModel.connectQuotes(isConnected: isConnected, quote: quote, quoteConnecting: quoteConnecting)
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
            Mixpanel.mainInstance().track(event: "goToConnectQuote_FromSheet")
            print("🔗 This quote is connecting with: \(String(describing: quote.connectedQuotes))")
        }
        .onAppear {
            Mixpanel.mainInstance().track(event: "leftFromConnectQuote_FromSheet")
        }
    }
}
