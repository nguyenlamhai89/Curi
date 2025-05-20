//
//  LinesView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 15/4/25.
//

import SwiftUI
import SwiftData
import WidgetKit

struct LinesView: View {
    /// SwiftData
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Quote.quoteAddedDate, order: .reverse) var quoteDatabase: [Quote]
    @Query var pencilDatabase: [HighlightPencil]
    
    /// Local View
    @ObservedObject var bookViewModel: BookViewModel
    var bookTitle: String
    var bookAuthor: String
    var bookHighlightName: String
    var bookLinesOriginal: [String]
    var defaultTextColor: String = "ink-500"
    var defaultBackgroundColor: String = "paper-500"
    
    var body: some View {
        VStack (spacing: curiSpacing(.sp8)) {
            ForEach(Array(bookLinesOriginal.enumerated()), id: \.offset) { lineNum, line in
                
                let quote = Quote(quoteID: UUID(), quoteLineNum: lineNum + 1, quoteAddedDate: Date(), quoteBook: bookTitle, quoteAuthor: bookAuthor, quoteContent: line, quoteHighlight: nil, isConnected: false, quoteNote: Note(noteContent: ""))
                
                Text(quote.quoteContent)
                    .curiTypo(.bkRegular16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onLongPressGesture(minimumDuration: 0.1) {
                        print("- Line: \(quote.quoteContent)")
                        print("- ID: \(quote.quoteID))")
                        print("- Line Num: \(quote.quoteLineNum)")
                        
//                        checkQuoteDatabase(checkingQuote: quote)
                        bookViewModel.checkQuoteDatabase(quoteDatabase: quoteDatabase, checkingQuote: quote, modelContext: modelContext)
                        
                    }
                    .onTapGesture {
//                        withAnimation {
//                            if let existingQuote = quoteDatabase.first(where: { $0.quoteContent == quote.quoteContent && $0.quoteLineNum == quote.quoteLineNum }) {
//                                if bookViewModel.selectedLine?.quoteLineNum == existingQuote.quoteLineNum {
//                                    bookViewModel.selectedLine = nil
//                                } else {
//                                    bookViewModel.selectedLine = existingQuote
//                                }
//                            } else {
//                                bookViewModel.selectedLine = nil
//                            }
//                            bookViewModel.pageIsSelected = true
                            
//                        }
//                        print("-- Ready to add Note: \(bookViewModel.selectedLine != nil ? "✅" : "🙅🏻‍♂️") - \(String(describing: bookViewModel.selectedLine?.quoteContent)), \(String(describing: bookViewModel.selectedLine?.quoteHighlight?.name ?? ""))")
//                        print("\(quote.quoteLineNum)) - \(quote.quoteContent)")
                        bookViewModel.checkSelectedLine(quoteDatabase: quoteDatabase, quote: quote)
                    }
                    .foregroundStyle(
                        {
                            if let quote = quoteDatabase.first(where: { $0.quoteContent == quote.quoteContent && $0.quoteLineNum == quote.quoteLineNum }) {
                                if bookViewModel.selectedLine?.quoteContent == quote.quoteContent && bookViewModel.selectedLine?.quoteLineNum == quote.quoteLineNum {
                                    return Color(quote.quoteHighlight?.highlightedTextColor ?? defaultTextColor)
                                    // Màu text đã được highlight, đang được chọn
                                } else {
                                    return Color(quote.quoteHighlight?.highlightedTextColor ?? defaultTextColor)
                                    // Màu text đã được highlight, chưa được chọn
                                }
                            } else {
                                return curiPalette(.ink500)
                                // Màu text mặc định (chưa được highlight, chưa được chọn)
                            }
                        }()
                    )
                    .background(
                        {
                            if let quote = quoteDatabase.first(where: { $0.quoteContent == quote.quoteContent && $0.quoteLineNum == quote.quoteLineNum }) {
                                if bookViewModel.selectedLine?.quoteContent == quote.quoteContent && bookViewModel.selectedLine?.quoteLineNum == quote.quoteLineNum {
                                    return Color(quote.quoteHighlight?.selectedHighlightedBackgroundColor ?? defaultBackgroundColor)
                                    // Màu background đã được highlight, đang được chọn
                                } else {
                                    return Color(quote.quoteHighlight?.defaultHighlightedBackgroundColor ?? defaultBackgroundColor)
                                    // Màu background đã được highlight, chưa được chọn
                                }
                                
                            } else {
                                return Color.clear
                                // Màu background mặc định (chưa được highlight, chưa được chọn)
                            }
                        }()
                    )
                    .animation(.easeInOut(duration: 0.1), value: quoteDatabase)
                    .simultaneousGesture(DragGesture())
            }
            .onChange(of: quoteDatabase) {
                bookViewModel.updateQOTD(quoteDatabase: quoteDatabase)
            }
            .onChange(of: bookViewModel.quoteChangedTrigger) {
                bookViewModel.updateQOTD(quoteDatabase: quoteDatabase)
            }
        }
    }
    
//    func checkQuoteDatabase(checkingQuote: Quote) {
//        //        if let existingQuote = quoteDatabase.first(where: { $0.quoteID == checkingQuote.quoteID }) {
//        if let existingQuote = quoteDatabase.first(where: { $0.quoteContent == checkingQuote.quoteContent && $0.quoteLineNum == checkingQuote.quoteLineNum }) {
//            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
//            SoundManager.access.play(sound: .highlightRemoved, soundEnabledInApp: bookViewModel.soundInApp)
//            modelContext.delete(existingQuote)
//        } else {
//            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
//            SoundManager.access.play(sound: .highlightAdded, soundEnabledInApp: bookViewModel.soundInApp)
//            checkingQuote.quoteHighlight = bookViewModel.selectedPen
//            modelContext.insert(checkingQuote)
//        }
//        
//    }
    
}
