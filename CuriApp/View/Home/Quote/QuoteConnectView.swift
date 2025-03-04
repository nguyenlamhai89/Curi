//
//  QuoteConnectView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 4/3/25.
//

import SwiftUI

struct QuoteConnectView: View {
    @State var searchLinkQuote: String = ""
    
    var body: some View {
        ScrollView {
            VStack (spacing: curiSpacing(.sp16)) {
                ForEach(0..<10) { book in
                    QuoteCardCheckbox(bookName: "Book \(book)", authorName: "Author of book \(book)", quoteContent: "\(book) - Can you not understand that liberty is worth more than just ribbons?", highlightTagName: "Discuss Later", action: {
                        print("Checked!")
                    })
                }
            }
        }
        .navigationTitle("Connected (0)")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, curiSpacing(.sp16))
        .scrollIndicators(.hidden)
        .searchable(text: $searchLinkQuote, placement:.navigationBarDrawer(displayMode: .always))
        .background(curiPalette(.paper500))
    }
}

#Preview {
    QuoteConnectView()
}
