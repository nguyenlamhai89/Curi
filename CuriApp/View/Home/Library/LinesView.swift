//
//  LinesView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 15/4/25.
//

import SwiftUI
import SwiftData

struct LinesView: View {
    @Bindable var bookViewModel: BookViewModel
    @Environment(\.modelContext) private var modelContext
    @Query var quoteDatabase: [Quote]
    @Query var pencilDatabase: [HighlightPencil]
    
    var bookID: UUID
    var bookTitle: String
    var bookAuthor: String
    var bookHighlightName: String
    var bookLinesOriginal: [String]
    
    var textHighlightedColor: String {
        bookViewModel.selectedPen?.highlightedTextColor ?? ""
    }

    var backgroundHighlightedColor: String {
        bookViewModel.selectedPen?.defaultHighlightedBackgroundColor ?? ""
    }
    
    var textHighlightedSelectingColor: String {
        bookViewModel.selectedPen?.highlightedTextColor ?? ""
    }
    
    var backgroundHighlightedSelectingColor: String {
        bookViewModel.selectedPen?.selectedHighlightedBackgroundColor ?? "" 
    }
    
//    @State var selectedLine: String? = nil
    
    var body: some View {
        VStack (spacing: 8) {
            ForEach(bookLinesOriginal, id: \.self) { line in
                Text(line)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onLongPressGesture(minimumDuration: 0.2) {
                        print("\(line)")
                        let quote = Quote(bookID: bookID, quoteBook: bookTitle, quoteAuthor: bookAuthor, quoteContent: line, quoteHighlight: bookViewModel.selectedPen!)
                        
                        print("- BookID: \(quote.bookID)")
                        print("- QuoteID: \(quote.quoteID)")
                        print("- Title: \(quote.quoteBook)")
                        print("- Author: \(quote.quoteAuthor)")
                        print("📝 -------- \(quote.quoteContent) - \(quote.quoteHighlight)")
                        
                        checkQuoteDatabase(checkingQuote: quote, currentLine: line)
                        
                    }
                    .onTapGesture {
                        if quoteDatabase.contains(where: { $0.quoteContent == line }) {
                            bookViewModel.selectedLine = (bookViewModel.selectedLine == line) ? nil : line
                        } else {
                            bookViewModel.selectedLine = nil
                        }
                        print("-- Ready to add Note: \(bookViewModel.selectedLine != nil ? "✅" : "🙅🏻‍♂️")")
//                        print("Quote content: \(bookViewModel.selectedLine)")
                    }
                    .foregroundStyle(
                        quoteDatabase.contains(where: { $0.quoteContent == line }) && bookViewModel.selectedLine == line
                        ? Color(textHighlightedSelectingColor)
                        : quoteDatabase.contains(where: { $0.quoteContent == line })
                          ? Color(textHighlightedColor)
                          : curiPalette(.ink500)
                    )
                    .background(
                        quoteDatabase.contains(where: { $0.quoteContent == line }) && bookViewModel.selectedLine == line
                        ? Color(backgroundHighlightedSelectingColor)
                        : quoteDatabase.contains(where: { $0.quoteContent == line })
                          ? Color(backgroundHighlightedColor)
                          : Color.clear
                    )
                    .animation(.easeInOut, value: quoteDatabase)
            }
            .onChange(of: quoteDatabase) {
                print("✅ [\(quoteDatabase.count)] Quotes: \(quoteDatabase)")
            }
        }
    }
    
    func checkQuoteDatabase(checkingQuote: Quote, currentLine: String) {
        if let existingQuote = quoteDatabase.first(where: { $0.quoteContent == currentLine }) {
            HapticsManager.access.play(haptics: .light)
            SoundManager.access.play(sound: .highlightRemoved)
            modelContext.delete(existingQuote)
        } else {
            HapticsManager.access.play(haptics: .light)
            SoundManager.access.play(sound: .highlightAdded)
            modelContext.insert(checkingQuote)
        }
    }
}
