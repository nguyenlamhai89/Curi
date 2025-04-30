//
//  BookModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 14/3/25.
//

import SwiftUI
import SwiftData

class Book: Identifiable, Codable {
    let id: UUID = UUID()
    var title: String
    var author: String
    var lines: [String]
    
    init(title: String, author: String, lines: [String]) {
        self.title = title
        self.author = author
        self.lines = lines
    }
}

@Model
class HighlightPencil {
    var name: String

    var primaryTextColor: String
    var primaryBackgroundColor: String
    
    var isPresentedRenameView: Bool
    
    var secondaryTextColor: String
    var secondaryBackgroundColor: String
    
    // Lines
    var highlightedTextColor: String
    var defaultHighlightedBackgroundColor: String
    var selectedHighlightedBackgroundColor: String
    
    init(name: String, primaryTextColor: String, primaryBackgroundColor: String, isPresentedRenameView: Bool = false, secondaryTextColor: String, secondaryBackgroundColor: String, highlightedTextColor: String, defaultHighlightedBackgroundColor: String, selectedHighlightedBackgroundColor: String) {
        self.name = name
        self.primaryTextColor = primaryTextColor
        self.primaryBackgroundColor = primaryBackgroundColor
        self.isPresentedRenameView = isPresentedRenameView
        self.secondaryTextColor = secondaryTextColor
        self.secondaryBackgroundColor = secondaryBackgroundColor
        self.highlightedTextColor = highlightedTextColor
        self.defaultHighlightedBackgroundColor = defaultHighlightedBackgroundColor
        self.selectedHighlightedBackgroundColor = selectedHighlightedBackgroundColor
    }
}

@Model
class Quote: Identifiable {
    var bookID: UUID
    var quoteID: UUID = UUID()
    var quoteAddedDate: Date = Date()
    var quoteBook: String
    var quoteAuthor: String
    var quoteContent: String
    var quoteHighlight: HighlightPencil
    
    var isConnected: Bool = false
    var connectedQuotes: [Quote]?
    
    @Relationship(deleteRule: .cascade) var quoteNote: Note?
    
    init(bookID: UUID, quoteBook: String, quoteAuthor: String, quoteContent: String, quoteHighlight: HighlightPencil, connectedQuotes: [Quote]? = nil, quoteNote: Note? = Note()) {
        self.bookID = bookID
        self.quoteBook = quoteBook
        self.quoteAuthor = quoteAuthor
        self.quoteContent = quoteContent
        self.quoteHighlight = quoteHighlight
        self.connectedQuotes = connectedQuotes
        self.quoteNote = quoteNote
    }
}

@Model
class Note: Identifiable {
    var noteID: UUID
    var noteContent: String = ""
    var hasContent: Bool {
        !noteContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    init(noteID: UUID = UUID(), noteContent: String = "") {
        self.noteID = noteID
        self.noteContent = noteContent
    }
}

extension Quote: CustomStringConvertible {
    var description: String {
        return """
        --- Quote(
            id: \(quoteID),
            content: \"\(quoteContent)\",
            book: \"\(quoteBook)\",
            author: \"\(quoteAuthor)\",
            highlight: \"\(quoteHighlight.name)\",
            Connect Status: \(isConnected)
        )
        """
    }
}
