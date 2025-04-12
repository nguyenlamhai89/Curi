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
    @Query var quoteDatabase: [Quote]
    
    @AppStorage("sampleQuote", store: UserDefaults(suiteName: "group.madebynham.curi")) var sampleQuote: String = "Can you not understand that liberty is worth more than just ribbons?"
    
    @Bindable var quote: Quote
    
    var body: some View {
        ScrollView {
            VStack (spacing: curiSpacing(.sp16)) {
                ForEach(quoteDatabase.filter { $0.quoteID != quote.quoteID }) { quoteInDatabase in
    
                    QuoteCardWithCheckbox(bookName: quoteInDatabase.quoteBook, authorName: quoteInDatabase.quoteAuthor, quoteContent: quoteInDatabase.quoteContent, highlightTagName: quoteInDatabase.quoteHighlightName, isConnected: quoteInDatabase.isConnected, action: {
                        
                        if quote.connectedQuotes?.contains(where: { $0.quoteID == quoteInDatabase.quoteID }) == false {
                            quoteInDatabase.isConnected = true
                            quote.connectedQuotes?.append(quoteInDatabase)
                            print("[\(quoteInDatabase.isConnected ? "✅" : "🙅🏼")] ID: \(quoteInDatabase.quoteID) - Quote: \(quoteInDatabase.quoteContent) - Connected: \(quoteInDatabase.isConnected)")
                        } else {
                            quoteInDatabase.isConnected = false
                            quote.connectedQuotes?.removeAll(where: { $0.quoteID == quoteInDatabase.quoteID })
                            print("[\(quoteInDatabase.isConnected ? "✅" : "🙅🏼")] ID: \(quoteInDatabase.quoteID) - Quote: \(quoteInDatabase.quoteContent) - Connected: \(quoteInDatabase.isConnected)")
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
            QuoteConnectView(quote: Quote(bookID: UUID(), quoteBook: "Hi", quoteAuthor: "Hi", quoteContent: "Bar", quoteHighlightName: "Discuss Later"))
        }
    }
}
