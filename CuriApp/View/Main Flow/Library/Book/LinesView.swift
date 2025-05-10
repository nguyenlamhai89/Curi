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
    @ObservedObject var bookViewModel: BookViewModel
    @Environment(\.modelContext) private var modelContext
//    @Query var quoteDatabase: [Quote]
    @Query(sort: \Quote.quoteAddedDate, order: .reverse) var quoteDatabase: [Quote]
    @Query var pencilDatabase: [HighlightPencil]
    
//    var bookID: UUID
    var bookTitle: String
    var bookAuthor: String
    var bookHighlightName: String
    var bookLinesOriginal: [String]
    
    var textHighlightedColor: String { // Màu text chính của highlight
        bookViewModel.selectedPen?.highlightedTextColor ?? ""
    }

    var backgroundHighlightedColor: String { // Màu background chính của highlight
        bookViewModel.selectedPen?.defaultHighlightedBackgroundColor ?? ""
    }
    
    var textHighlightedSelectingColor: String { // Màu text chính của highlight khi đang được chọn
        bookViewModel.selectedPen?.highlightedTextColor ?? ""
    }
    
    var backgroundHighlightedSelectingColor: String { // Màu background chính của highlight khi đang được chọn
        bookViewModel.selectedPen?.selectedHighlightedBackgroundColor ?? ""
    }
    

    
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
                        
                        checkQuoteDatabase(checkingQuote: quote)
                        
                    }
                    .onTapGesture {
                        withAnimation {
                            if let existingQuote = quoteDatabase.first(where: { $0.quoteContent == quote.quoteContent && $0.quoteLineNum == quote.quoteLineNum }) {
                                if bookViewModel.selectedLine?.quoteID == existingQuote.quoteID {
                                    bookViewModel.selectedLine = nil
                                } else {
                                    bookViewModel.selectedLine = existingQuote
                                }
                            } else {
                                bookViewModel.selectedLine = nil
                            }
                            bookViewModel.pageIsSelected = true
                        }
                        print("-- Ready to add Note: \(bookViewModel.selectedLine != nil ? "✅" : "🙅🏻‍♂️") - \(String(describing: bookViewModel.selectedLine?.quoteContent)), \(String(describing: bookViewModel.selectedLine?.quoteHighlight?.name ?? ""))")
                        print("\(quote.quoteLineNum)) - \(quote.quoteContent)")
                    }
                    .foregroundStyle(
                        {
                            if let quote = quoteDatabase.first(where: { $0.quoteContent == quote.quoteContent && $0.quoteLineNum == quote.quoteLineNum }) {
                                if bookViewModel.selectedLine?.quoteContent == quote.quoteContent && bookViewModel.selectedLine?.quoteLineNum == quote.quoteLineNum {
                                    return Color(quote.quoteHighlight?.highlightedTextColor ?? textHighlightedSelectingColor)
                                } else {
                                    return Color(quote.quoteHighlight?.highlightedTextColor ?? textHighlightedColor)
                                }
                            } else {
                                return curiPalette(.ink500)
                            }
                        }()
                    )
                    .background(
                        {
                            if let quote = quoteDatabase.first(where: { $0.quoteContent == quote.quoteContent && $0.quoteLineNum == quote.quoteLineNum }) {
                                if bookViewModel.selectedLine?.quoteContent == quote.quoteContent && bookViewModel.selectedLine?.quoteLineNum == quote.quoteLineNum {
                                    return Color(quote.quoteHighlight?.selectedHighlightedBackgroundColor ?? backgroundHighlightedSelectingColor)
                                } else {
                                    return Color(quote.quoteHighlight?.defaultHighlightedBackgroundColor ?? backgroundHighlightedColor)
                                }
                                
                            } else {
                                return Color.clear
                            }
                        }()
                    )
                    .animation(.easeInOut(duration: 0.1), value: quoteDatabase)
                    .simultaneousGesture(DragGesture())
            }
            .onChange(of: quoteDatabase) {
                print("✅ [\(quoteDatabase.count)] Quotes: \(quoteDatabase)")
            }
        }
    }
    
    func checkQuoteDatabase(checkingQuote: Quote) {
        //        if let existingQuote = quoteDatabase.first(where: { $0.quoteID == checkingQuote.quoteID }) {
        if let existingQuote = quoteDatabase.first(where: { $0.quoteContent == checkingQuote.quoteContent && $0.quoteLineNum == checkingQuote.quoteLineNum }) {
            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
            SoundManager.access.play(sound: .highlightRemoved, soundEnabledInApp: bookViewModel.soundInApp)
            modelContext.delete(existingQuote)
        } else {
            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
            SoundManager.access.play(sound: .highlightAdded, soundEnabledInApp: bookViewModel.soundInApp)
            checkingQuote.quoteHighlight = bookViewModel.selectedPen
            modelContext.insert(checkingQuote)
        }
        
        WidgetDataManager().updateQuoteOnWidget(quoteDatabase: quoteDatabase)
        
    }
    
    
}
