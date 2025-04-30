//
//  QuoteConnectView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 4/3/25.
//

import SwiftUI
import SwiftData

struct QuoteConnectView: View {
    @State var searchLinkQuote: String = ""
    @State var connectedQuote: Int = 0
    
//    @Environment(\.modelContext) var modelContext
//    @Query var quoteDatabase: [Quote]
    @Query(sort: \Quote.quoteAddedDate, order: .reverse) var quoteDatabase: [Quote]
    
    var filteredQuoteContent: [Quote] {
        guard !searchLinkQuote.isEmpty else {
            return quoteDatabase
        }
        return quoteDatabase.filter {
            $0.quoteContent.localizedCaseInsensitiveContains(searchLinkQuote)
        }
    }
    
    @Query var pencilDatabase: [HighlightPencil]
    
    @AppStorage("sampleQuote", store: UserDefaults(suiteName: "group.madebynham.curi")) var sampleQuote: String = "Can you not understand that liberty is worth more than just ribbons?"
    
    @Bindable var quote: Quote
    
    var body: some View {
        ScrollView {
            VStack (spacing: curiSpacing(.sp16)) {
                ForEach(filteredQuoteContent.filter { $0.quoteID != quote.quoteID }) { quoteConnecting in
    
                    QuoteCardWithCheckbox(bookName: quoteConnecting.quoteBook, authorName: quoteConnecting.quoteAuthor, quoteContent: quoteConnecting.quoteContent, highlightTagName: quoteConnecting.quoteHighlight.name, highlightTagColor: quoteConnecting.quoteHighlight.primaryBackgroundColor, isConnected: quoteConnecting.isConnected, action: {
                        
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
        .navigationTitle("Connected (\(quote.connectedQuotes?.count ?? 0))")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, curiSpacing(.sp16))
        .scrollIndicators(.hidden)
        .searchable(text: $searchLinkQuote, placement:.navigationBarDrawer(displayMode: .always))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(curiPalette(.paper500))
        .onAppear {
            print("🔗 This quote is connecting with: \(String(describing: quote.connectedQuotes))")
        }
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = true
    VStack {
        Text("Test")
    }
    .sheet(isPresented: $isPresented) {
        NavigationView {
            QuoteConnectView(quote: Quote(bookID: UUID(), quoteBook: "Hi", quoteAuthor: "Hi", quoteContent: "Bar", quoteHighlight: HighlightPencil(name: "Discuss Later", primaryTextColor: "paper-500", primaryBackgroundColor: "blue-300", secondaryTextColor: "blue-500", secondaryBackgroundColor: "blue-100", highlightedTextColor: "blue-500", defaultHighlightedBackgroundColor: "blue-100", selectedHighlightedBackgroundColor: "blue-200")))
        }
    }
}
