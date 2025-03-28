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
    
    @Bindable var bookViewModel: BookViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if bookViewModel.highlightDatabase.isEmpty {
                    Spacer()
                    EmptyStateDescription(headline: "No highlights yet, but that’s okay,", paragraph: "Start with a book, and mark your way!")
                    Spacer()
                } else {
                    ScrollView {
                        VStack (spacing: curiSpacing(.sp16)) {
                            ForEach(bookViewModel.highlightDatabase, id: \.self) { highlight in
                                QuoteCard(bookName: "Book", authorName: "Author", quoteContent: "\(highlight)", highlightTagName: "Discuss Later", action: {
                                    quoteCardisPresented.toggle()
                                })
                                .onAppear {
                                    print("Type: \(type(of: highlight))")
                                }
                            }
                        }
                    }
//                    .navigationTitle("All Quotes")
//                    .navigationBarTitleDisplayMode(.inline)
//                    .padding(.horizontal, curiSpacing(.sp16))
//                    .frame(maxWidth: .infinity)
//                    .scrollIndicators(.hidden)
//                    .searchable(text: $searchAvailableQuote, placement:.navigationBarDrawer(displayMode: .always), prompt: "Search Your Quote")
//                    .sheet(isPresented: $quoteCardisPresented) {
//                        QuoteNoteSheetView()
//                    }
                }
            }
            .navigationTitle("All Quotes")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal, curiSpacing(.sp16))
            .frame(maxWidth: .infinity)
            .scrollIndicators(.hidden)
            .searchable(text: $searchAvailableQuote, placement:.navigationBarDrawer(displayMode: .always), prompt: "Search Your Quote")
            .sheet(isPresented: $quoteCardisPresented) {
                QuoteNoteSheetView()
            }
        }
        .background(curiPalette(.paper500))
    }
}

#Preview {
    @Previewable @Bindable var bookViewModel = BookViewModel()
    SearchView(bookViewModel: bookViewModel)
}
