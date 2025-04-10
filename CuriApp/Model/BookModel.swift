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

//@Model
//class Highlight {
//    var bookID: UUID
//    var highlightID: UUID = UUID()
//    var bookTitle: String
//    var bookAuthor: String
//    var content: String
//    @Relationship(deleteRule: .cascade) var note: Note?
//    
//    init(bookID: UUID,
//         bookTitle: String,
//         bookAuthor: String,
//         content: String,
//         note: Note? = nil) {
//        self.bookID = bookID
//        self.bookTitle = bookTitle
//        self.bookAuthor = bookAuthor
//        self.content = content
//        self.note = note
//    }
//}

@Model
class Quote: Identifiable {
    var bookID: UUID
    var quoteID: UUID = UUID()
    var quoteBook: String
    var quoteAuthor: String
    var quoteContent: String
    var quoteHighlightName: String?
    var isConnected: Bool
    
    var connectedQuotes: [Quote]?
    
    @Relationship(deleteRule: .cascade) var quoteNote: Note?
    
    init(bookID: UUID, quoteBook: String, quoteAuthor: String, quoteContent: String, quoteHighlightName: String? = nil, isConnected: Bool = false, connectedQuotes: [Quote]? = nil, quoteNote: Note? = nil) {
        self.bookID = bookID
        self.quoteBook = quoteBook
        self.quoteAuthor = quoteAuthor
        self.quoteContent = quoteContent
        self.quoteHighlightName = quoteHighlightName
        self.isConnected = isConnected
        self.connectedQuotes = connectedQuotes
        self.quoteNote = quoteNote
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
            highlightName: \"\(quoteHighlightName ?? "None")\",
            Connect Status: \(isConnected)
        )
        """
    }
}

//@Model
//class Note {
//    var bookID: UUID
//    var highlightID: UUID
//    var note: String
//    
//    init(bookID: UUID, highlightID: UUID, note: String) {
//        self.bookID = bookID
//        self.highlightID = highlightID
//        self.note = note
//    }
//}
@Model
class Note: Identifiable {
    var bookID: UUID
    var quoteID: UUID
    var noteID: UUID = UUID()
    var noteContent: String
    
    init(bookID: UUID, quoteID: UUID, noteContent: String) {
        self.bookID = bookID
        self.quoteID = quoteID
        self.noteContent = noteContent
    }
}
