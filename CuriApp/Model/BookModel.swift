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
class ReadTime {
    var timeCheckpoint: Double
    
    init(timeCheckpoint: Double = 0) {
        self.timeCheckpoint = timeCheckpoint
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
    var quoteLineNum: Int
    var quoteAddedDate: Date = Date()
    var quoteBook: String
    var quoteAuthor: String
    var quoteContent: String
    var quoteHighlight: HighlightPencil
    
    var isConnected: Bool
    var connectedQuotes: [Quote]?
    
    var quoteNote: Note
    
    init(bookID: UUID, quoteLineNum: Int, quoteBook: String, quoteAuthor: String, quoteContent: String, quoteHighlight: HighlightPencil, isConnected: Bool, connectedQuotes: [Quote]? = nil, quoteNote: Note = Note()) {
        self.bookID = bookID
        self.quoteLineNum = quoteLineNum
        self.quoteBook = quoteBook
        self.quoteAuthor = quoteAuthor
        self.quoteContent = quoteContent
        self.quoteHighlight = quoteHighlight
        self.isConnected = isConnected
        self.connectedQuotes = connectedQuotes
        self.quoteNote = quoteNote
    }
}

@Model
class Note {
//    var noteID: UUID = UUID()
    var noteContent: String
    var hasContent: Bool {
        !noteContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    init(noteContent: String = "") {
        self.noteContent = noteContent
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
            highlight: \"\(quoteHighlight.name)\",
            Connect Status: \(isConnected)
        )
        """
    }
}
