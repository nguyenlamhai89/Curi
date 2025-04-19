//
//  QuoteView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 12/3/25.
//

import SwiftUI
import SwiftData

struct QuoteView: View {
    
    
    @Environment(\.modelContext) var modelContext

    @Bindable var bookViewModel: BookViewModel
    @Query var quoteDatabase: [Quote]
    
    @State var viewAllNavigation: Bool = false
//    @State var isPresentedQuoteSheetView: Bool = false
    @State var newHighlightName: String = ""
    
    @Binding var isPresentedRenameView: Bool
    
    var quoteOnPaper: Quote {
        if let first = quoteDatabase.first {
            return first
        } else {
            return Quote(bookID: UUID(), quoteBook: "", quoteAuthor: "", quoteContent: "", quoteHighlight: HighlightPencil(name: "", primaryTextColor: "", primaryBackgroundColor: "b", secondaryTextColor: "", secondaryBackgroundColor: "", highlightedTextColor: "", defaultHighlightedBackgroundColor: "", selectedHighlightedBackgroundColor: ""), quoteNote: Note())
        }
    }
    
    var emptyHeadline: String = "No quotes yet, but that’s okay,"
    var emptyParagraph: String = "Start with a book, and mark your way!"
    
    var body: some View {
        if quoteDatabase.isEmpty {
            EmptyStateDescription(headline: emptyHeadline, paragraph: emptyParagraph)
        } else {
            VStack (spacing: 0) {
                VStack (spacing: 0) {
                    QuotePaperGroup(highlight: quoteOnPaper.quoteHighlight, quote: quoteOnPaper, quoteContent: quoteOnPaper.quoteContent, quoteAuthor: quoteOnPaper.quoteAuthor, quoteBook: quoteOnPaper.quoteBook, paperAction: {
                        bookViewModel.quoteNoteSheetViewIsPresented.toggle()
                    }, highlightAction: {
                        isPresentedRenameView.toggle()
                    })
                    .padding(curiSpacing(.sp16))
                                        
                    TextButtonPlain(content: "Show All (\(quoteDatabase.count))") {
                        viewAllNavigation.toggle()
                        print("All")
                    }
                    .bottomNavigationSpacing
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 74)
            }
            .sheet(isPresented: $bookViewModel.quoteNoteSheetViewIsPresented) {
                QuoteNoteSheetView(bookViewModel: bookViewModel, quote: quoteOnPaper)
            }
            .navigationDestination(isPresented: $viewAllNavigation) {
                AllQuotesView(bookViewModel: bookViewModel)
            }
        }
        
    }
}

#Preview {
    @Previewable @State var bookViewModel = BookViewModel()
    QuoteView(bookViewModel: bookViewModel, isPresentedRenameView: .constant(false))
}
