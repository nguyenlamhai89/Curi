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
    
    var bookID: UUID
    var bookTitle: String
    var bookAuthor: String
    var bookHighlightName: String
    var bookLinesOriginal: [String]
    
//    var textHighlighted: Color = bookViewModel.selectedPen?.highlightedTextColor ?? curiPalette(.blue500)
//    var backgroundHighlighted: Color = bookViewModel.selectedPen?.unselectedHighlightedBackgroundColor ?? Color.clear
    
    var textHighlightedColor: Color {
        bookViewModel.selectedPen?.highlightedTextColor ?? Color.clear
    }

    var backgroundHighlightedColor: Color {
        bookViewModel.selectedPen?.unselectedHighlightedBackgroundColor ?? Color.clear
    }
    
//    var selectedHighlightPen: HighlightPen?
    
    var body: some View {
        VStack (spacing: 8) {
            ForEach(bookLinesOriginal, id: \.self) { line in
                Text(line)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onLongPressGesture {
                        print("\(line)")
                        let quote = Quote(bookID: bookID, quoteBook: bookTitle, quoteAuthor: bookAuthor, quoteContent: line, quoteHighlightName: bookHighlightName)
                        
                        print("- BookID: \(quote.bookID)")
                        print("- QuoteID: \(quote.quoteID)")
                        print("- Title: \(quote.quoteBook)")
                        print("- Author: \(quote.quoteAuthor)")
                        print("📝 -------- \(quote.quoteContent) - \(quote.quoteHighlightName)")

                        checkQuoteDatabase(checkingQuote: quote, currentLine: line)
                        
                    }
//                    .foregroundStyle(quoteDatabase.contains(where: { $0.quoteContent == line }) ? curiPalette(.blue500) : curiPalette(.ink500))
//                    .background(quoteDatabase.contains(where: { $0.quoteContent == line }) ? curiPalette(.blue100) : Color.clear)
                    .foregroundStyle(quoteDatabase.contains(where: { $0.quoteContent == line }) ? textHighlightedColor : curiPalette(.ink500))
                    .background(quoteDatabase.contains(where: { $0.quoteContent == line }) ? backgroundHighlightedColor : Color.clear)
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

//#Preview {
//    LinesView(quoteDatabase: <#T##[Quote]#>, bookID: <#T##UUID#>, bookTitle: <#T##String#>, bookAuthor: <#T##String#>, bookHighlightName: <#T##String#>, bookLinesOriginal: <#T##[String]#>)
//}
