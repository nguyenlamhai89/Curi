//
//  SearchSheetView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI
import SwiftData

//struct IdentifiableHighlight: Identifiable {
//    var id = UUID()
//    var content: String
//}

struct AllQuotesView: View {
    @State var searchAvailableQuote: String = ""
    @Binding var quoteCardisPresented: Bool
    
    @Bindable var bookViewModel: BookViewModel
    @Query var highlightDatabase: [Highlight]
//    @State var itemSelected: IdentifiableHighlight?
    
    var emptyHeadline: String = "No quotes yet, but that’s okay,"
    var emptyParagraph: String = "Start with a book, and mark your way!"
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack (spacing: curiSpacing(.sp16)) {
                        ForEach(highlightDatabase, id: \.self) { itemHighlight in
                            QuoteCard(
                                bookName: itemHighlight.bookTitle, authorName: itemHighlight.bookAuthor, quoteContent: "\(itemHighlight.content)", highlightTagName: "Discuss Later", action: {
//                                        self.itemSelected = IdentifiableHighlight(content: itemHighlight)
                                    self.quoteCardisPresented.toggle()
//                                        print("HAINL self.itemSelected \(String(describing: self.itemSelected))")
                                }
                            )
//                                .sheet(isPresented: $quoteCardisPresented, content: {
//                                    QuoteNoteSheetView(bookViewModel: bookViewModel, highlight: itemHighlight)
//                                })
//                                .sheet(item: $itemSelected) { itemSelected in
//                                    QuoteNoteSheetView(bookViewModel: bookViewModel, highlight: itemSelected.content)
//                                }
                        }
                    }
                }
            }
            .navigationTitle("All Quotes")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal, curiSpacing(.sp16))
            .frame(maxWidth: .infinity)
            .scrollIndicators(.hidden)
            .searchable(text: $searchAvailableQuote, placement:.navigationBarDrawer(displayMode: .always), prompt: "Search Your Quote")
            
        }
        .background(curiPalette(.paper500))
    }
}

#Preview {
    @Previewable @Bindable var bookViewModel = BookViewModel()
    @Previewable @State var quoteCardisPresented: Bool = false
    AllQuotesView(quoteCardisPresented: $quoteCardisPresented, bookViewModel: bookViewModel)
}
