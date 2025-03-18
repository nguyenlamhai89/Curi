//
//  SearchSheetView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI

struct SearchView: View {
    @State var searchAvailableQuote: String = ""
    @State var quoteCardisPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: curiSpacing(.sp16)) {
                    ForEach(0..<10) { book in
                        QuoteCard(bookName: "Book \(book)", authorName: "Author of book \(book)", quoteContent: "\(book) - Can you not understand that liberty is worth more than just ribbons?", highlightTagName: "Discuss Later", action: {
                            quoteCardisPresented.toggle()
                        })
                    }
                }
            }
            .navigationTitle("All Quotes")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal, curiSpacing(.sp16))
            .scrollIndicators(.hidden)
            .searchable(text: $searchAvailableQuote, placement:.navigationBarDrawer(displayMode: .always), prompt: "Search Your Quote")
            .sheet(isPresented: $quoteCardisPresented) {
                QuoteNoteSheetView()
            }
            .background(curiPalette(.paper500))
        }
    }
}

#Preview {
    SearchView()
}
