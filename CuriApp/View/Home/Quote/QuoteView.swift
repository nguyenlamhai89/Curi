//
//  QuoteView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 12/3/25.
//

import SwiftUI
import SwiftData

//struct HighlightNode: View {
//    var highlightName: String
//    var highlightColor: Color
//    var action: () -> Void
//    
//    var body: some View {
//        VStack (spacing: curiSpacing(.sp4)) {
//            HighlightButton(content: highlightName, color: highlightColor) {
//                action()
//                print("Discuss Later Pressed")
//            }
//            Circle()
//                .fill(highlightColor)
//                .frame(width: 24, height: 24)
//        }
//    }
//}
//
//struct QuoteNode: View {
//    var quoteTitle: String
//    var body: some View {
//        VStack(spacing: curiSpacing(.sp4)) {
//            Text(quoteTitle)
//                .curiTypo(.bkRegular12)
//                .foregroundStyle(curiPalette(.ink500))
//                .lineLimit(2)
//                .multilineTextAlignment(.center)
//            Circle()
//                .fill(curiPalette(.ink100))
//                .frame(width: 24, height: 24)
//        }
//        .frame(maxWidth: 160)
//    }
//}

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
    
    var quoteInPaper: String {
        quoteDatabase.first?.quoteContent ?? "No quotes yet"
    }
    var authorInPaper: String {
        quoteDatabase.first?.quoteAuthor ?? "Unknown Author"
    }
    var bookInPaper: String {
        quoteDatabase.first?.quoteBook ?? "Unknown Book"
    }
    
    var emptyHeadline: String = "No quotes yet, but that’s okay,"
    var emptyParagraph: String = "Start with a book, and mark your way!"
    
    var body: some View {
        VStack (spacing: 0) {
            VStack (spacing: 0) {
                QuotePaperGroup(quoteInPaper: quoteInPaper, authorInPaper: authorInPaper, bookInPaper: bookInPaper, paperAction: {
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
            QuoteNoteSheetView(bookViewModel: bookViewModel, quote: quoteInPaper, author: authorInPaper, book: bookInPaper)
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

#Preview {
    @Previewable @State var bookViewModel = BookViewModel()
    @Previewable @State var nameHighlightPrimary: String = "Discuss Later"
    @Previewable @State var nameHighlightSecondary: String = "Good Point"
    @Previewable @State var renameViewPrimary: Bool = false
    @Previewable @State var renameViewSecondary: Bool = false
    @Previewable @State var quoteCardIsPresented: Bool = false
    @Previewable @State var viewAllNavigation: Bool = false
    
    QuoteView(bookViewModel: bookViewModel, nameHighlightPrimary: $nameHighlightPrimary, nameHighlightSecondary: $nameHighlightSecondary, placeholderHighlightName: "Your highlight name", renameViewPrimary: $renameViewPrimary, renameViewSecondary: $renameViewSecondary, quoteCardIsPresented: $quoteCardIsPresented, viewAllNavigation: $viewAllNavigation)
}
