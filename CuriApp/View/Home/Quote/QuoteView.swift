//
//  QuoteView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 12/3/25.
//

import SwiftUI
import SwiftData

struct QuoteView: View {
    // Binding from HomeView
    @Bindable var bookViewModel: BookViewModel
    @Query var quoteDatabase: [Quote]
    
    @Binding var nameHighlightPrimary: String
    @Binding var nameHighlightSecondary: String
    var placeholderHighlightName: String
    @Binding var renameViewPrimary: Bool
    @Binding var renameViewSecondary: Bool
    
    @Binding var quoteCardIsPresented: Bool
    @Binding var viewAllNavigation: Bool
    
    var quote: Quote {
        if let first = quoteDatabase.first {
            return first
        } else {
            return Quote(bookID: UUID(), quoteBook: "", quoteAuthor: "", quoteContent: "")
        }
    }
    
//    var quoteInPaper: String {
//        quoteDatabase.first?.quoteContent ?? ""
//    }
//    var authorInPaper: String {
//        quoteDatabase.first?.quoteAuthor ?? ""
//    }
//    var bookInPaper: String {
//        quoteDatabase.first?.quoteBook ?? ""
//    }
    
    var emptyHeadline: String = "No quotes yet, but that’s okay,"
    var emptyParagraph: String = "Start with a book, and mark your way!"
    
    var body: some View {
        if quoteDatabase.isEmpty {
            EmptyStateDescription(headline: emptyHeadline, paragraph: emptyParagraph)
        } else {
            VStack (spacing: 0) {
                VStack (spacing: 0) {
                    QuotePaperGroup(quoteInPaper: quote.quoteContent, authorInPaper: quote.quoteAuthor, bookInPaper: quote.quoteBook, paperAction: {
                        quoteCardIsPresented.toggle()
                    }, highlightContent: nameHighlightPrimary, highlightColor: curiPalette(.blue300), highlightAction: {
                        renameViewPrimary.toggle()
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
            .sheet(isPresented: $quoteCardIsPresented) {
    //            QuoteNoteSheetView(bookViewModel: bookViewModel, quote: quoteInPaper, author: authorInPaper, book: bookInPaper)
//                QuoteNoteSheetView(bookViewModel: bookViewModel, quote: quoteOfTheDay.quoteContent, author: quoteOfTheDay.quoteAuthor, book: quoteOfTheDay.quoteBook)
                QuoteNoteSheetView(bookViewModel: bookViewModel, quote: quote)
            }
            .navigationDestination(isPresented: $viewAllNavigation) {
                AllQuotesView(bookViewModel: bookViewModel)
            }
            .overlay {
                if renameViewPrimary {
                    RenameHighlightView(backgroundColor: curiPalette(.blue500),
                                        placeholderHighlightName: placeholderHighlightName,
                                        highlightName: $nameHighlightPrimary,
                                        viewIsPresented: $renameViewPrimary)
                }
            }
        }
        
    }
}

#Preview {
    @Previewable @State var bookViewModel = BookViewModel()
    @Previewable @State var nameHighlightPrimary: String = "Discuss Later"
    @Previewable @State var nameHighlightSecondary: String = "Good Point"
    @Previewable @State var renameViewPrimary: Bool = false
    @Previewable @State var renameViewSecondary: Bool = false
    @Previewable @State var quoteCardIsPresented: Bool = false
    @Previewable @State var viewAllNavigation: Bool = false
    
    QuoteView(bookViewModel: bookViewModel, nameHighlightPrimary: $nameHighlightPrimary, nameHighlightSecondary: $nameHighlightSecondary, placeholderHighlightName: "Your highlight name", renameViewPrimary: $renameViewPrimary, renameViewSecondary: $renameViewSecondary, quoteCardIsPresented: $quoteCardIsPresented, viewAllNavigation: $viewAllNavigation)
//    QuoteView(bookViewModel: bookViewModel, nameHighlightPrimary: $nameHighlightPrimary, nameHighlightSecondary: $nameHighlightSecondary, placeholderHighlightName: "Highlight Name", renameViewPrimary: $renameViewPrimary, renameViewSecondary: $renameViewSecondary, quoteCardIsPresented: $quoteCardIsPresented, viewAllNavigation: $viewAllNavigation, quoteInPaper: "Unknow Quote", authorInPaper: "Unknow Author", bookInPaper: "Unknow Book")
}
