//
//  QuoteConnectView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 4/3/25.
//

import SwiftUI

struct QuoteConnectView: View {
    @State var searchLinkQuote: String = ""
    @State var connectedQuote: Int = 0
    
    @AppStorage("sampleQuote", store: UserDefaults(suiteName: "group.madebynham.curi")) var sampleQuote: String = "Can you not understand that liberty is worth more than just ribbons?"
    
    var body: some View {
        ScrollView {
            VStack (spacing: curiSpacing(.sp16)) {
                ForEach(0..<10) { book in
                    QuoteCardCheckbox(bookName: "Book \(book)", authorName: "Author of book \(book)", quoteContent: "\(book) - \(sampleQuote)", highlightTagName: "Discuss Later", action: {
//                        print("Checked!")
                    }, connectedQuote: $connectedQuote)
                }
            }
        }
        .navigationTitle("Connected (\(connectedQuote))")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, curiSpacing(.sp16))
        .scrollIndicators(.hidden)
        .searchable(text: $searchLinkQuote, placement:.navigationBarDrawer(displayMode: .always))
        .background(curiPalette(.paper500))
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = true
    VStack {
        Text("Test")
    }
    .sheet(isPresented: $isPresented) {
        NavigationView {
            QuoteConnectView()
        }
    }
}
