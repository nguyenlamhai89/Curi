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
class UserSettingsStats {
    var totalReadTime: Double = 0
    var soundInApp: Bool = true
    var vibrationInApp: Bool = true
    
    init(totalReadTime: Double, soundInApp: Bool, vibrationInApp: Bool) {
        self.totalReadTime = totalReadTime
        self.soundInApp = soundInApp
        self.vibrationInApp = vibrationInApp
    }
}

@Model
class HighlightPencil {
    var name: String = "Discuss Later"

    var primaryTextColor: String = "paper-500"
    var primaryBackgroundColor: String = "blue-300"
    
    var isPresentedRenameView: Bool = false
    
    var secondaryTextColor: String = "blue-500"
    var secondaryBackgroundColor: String = "blue-100"
    
    // Lines
    var highlightedTextColor: String = "blue-500"
    var defaultHighlightedBackgroundColor: String = "blue-100"
    var selectedHighlightedBackgroundColor: String = "blue-200"
    
    init(name: String, primaryTextColor: String, primaryBackgroundColor: String, isPresentedRenameView: Bool, secondaryTextColor: String, secondaryBackgroundColor: String, highlightedTextColor: String, defaultHighlightedBackgroundColor: String, selectedHighlightedBackgroundColor: String) {
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
//    var bookID: UUID
    var quoteID: UUID = UUID()
    var quoteLineNum: Int = 0
    var quoteAddedDate: Date = Date()
    var quoteBook: String = ""
    var quoteAuthor: String = ""
    var quoteContent: String = ""
    var quoteHighlight: HighlightPencil? = nil
    
    var isConnected: Bool = false
    var connectedQuotes: [Quote]? = nil
    
    var quoteNote: Note = Note()
    
    init(quoteID: UUID = UUID(), quoteLineNum: Int = 0, quoteAddedDate: Date = Date(), quoteBook: String = "", quoteAuthor: String = "", quoteContent: String = "", quoteHighlight: HighlightPencil? = nil, isConnected: Bool = false, connectedQuotes: [Quote]? = nil, quoteNote: Note = Note()) {
//        self.bookID = bookID
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
            highlight: \"\(String(describing: quoteHighlight?.name))\",
            Connect Status: \(isConnected)
        )
        """
    }
}
