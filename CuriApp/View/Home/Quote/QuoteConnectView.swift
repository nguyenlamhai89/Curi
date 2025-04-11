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
    
    @Query var quoteDatabase: [Quote]
    
    @AppStorage("sampleQuote", store: UserDefaults(suiteName: "group.madebynham.curi")) var sampleQuote: String = "Can you not understand that liberty is worth more than just ribbons?"
    
    @Bindable var quote: Quote
    
    var body: some View {
        ScrollView {
            VStack (spacing: curiSpacing(.sp16)) {
                ForEach(quoteDatabase) { quoteItem in
                    QuoteCardWithCheckbox(bookName: quoteItem.quoteBook, authorName: quoteItem.quoteAuthor, quoteContent: quoteItem.quoteContent, highlightTagName: "Discuss Later", action: {
                        
//                        quote.connectedQuotes?.append(quoteItem)
                        
                        if quote.connectedQuotes?.contains(where: {
                            $0.quoteContent == quoteItem.quoteContent && $0.quoteBook == quoteItem.quoteBook
                        }) == false {
                            quote.connectedQuotes?.append(quoteItem)
                            quote.isConnected = true
                        } else {
                            quote.connectedQuotes?.removeAll(where: {
                                $0.quoteContent == quoteItem.quoteContent && $0.quoteBook == quoteItem.quoteBook
                            })
                            quote.isConnected = false
                        }
                        
                        print("🔗 Connected Quotes for this Quote: \(String(describing: quote.connectedQuotes))")
                        
                    }, connectedQuote: $connectedQuote)
                }
            }
        }
        .navigationTitle("Connected (\(connectedQuote))")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, curiSpacing(.sp16))
        .scrollIndicators(.hidden)
        .searchable(text: $searchLinkQuote, placement:.navigationBarDrawer(displayMode: .always))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(curiPalette(.paper500))
        .onAppear {
            print("Quote Connecting With: \(quote)")
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
            QuoteConnectView(quote: Quote(bookID: UUID(), quoteBook: "Hi", quoteAuthor: "Hi", quoteContent: "Bar"))
        }
    }
}
