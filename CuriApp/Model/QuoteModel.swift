//
//  QuoteModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 23/5/25.
//

import SwiftUI
import SwiftData

@Model
class Quote {
//    var bookID: UUID
    var quoteID: UUID = UUID()
    var quoteLineNum: Int = 0
    var quoteAddedDate: Date = Date()
    var quoteBook: String = ""
    var quoteAuthor: String = ""
    var quoteContent: String = ""
    
    @Relationship(inverse: \HighlightPencil.highlightQuote)
    var quoteHighlight: HighlightPencil? = nil
    
    var isConnected: Bool = false
    
    @Relationship(inverse: \Quote.inverseConnectedQuotes)
    var connectedQuotes: [Quote]? = nil
    var inverseConnectedQuotes: [Quote]? = nil
    
    @Relationship(inverse: \Note.noteQuote)
    var quoteNote: Note? = nil
    
    // Inversed with User: quoteDatabase
    var userQuoteDatabase: User? = nil
    
    init(quoteID: UUID = UUID(), quoteLineNum: Int = 0, quoteAddedDate: Date = Date(), quoteBook: String = "", quoteAuthor: String = "", quoteContent: String = "", quoteHighlight: HighlightPencil? = nil, isConnected: Bool = false, connectedQuotes: [Quote]? = nil, quoteNote: Note? = nil) {
        self.quoteLineNum = quoteLineNum
        self.quoteAddedDate = quoteAddedDate
        self.quoteBook = quoteBook
        self.quoteAuthor = quoteAuthor
        self.quoteContent = quoteContent
        self.quoteHighlight = quoteHighlight
        self.isConnected = isConnected
        self.connectedQuotes = connectedQuotes
        self.quoteNote = quoteNote
    }
}

extension Quote: CustomStringConvertible {
    var description: String {
        return """
        --- Quote(
            line: \(quoteLineNum),
            content: \"\(quoteContent)\",
            book: \"\(quoteBook)\",
            author: \"\(quoteAuthor)\",
            highlight: \"\(String(describing: quoteHighlight?.name))\",
            Connect Status: \(isConnected)
        )
        """
    }
}
