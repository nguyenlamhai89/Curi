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
class Highlight {
    var bookID: UUID
    var highlightID: UUID = UUID()
    var bookTitle: String
    var bookAuthor: String
    var content: String
    @Relationship(deleteRule: .cascade) var note: Note?
    
    init(bookID: UUID,
         bookTitle: String,
         bookAuthor: String,
         content: String,
         note: Note? = nil) {
        self.bookID = bookID
        self.bookTitle = bookTitle
        self.bookAuthor = bookAuthor
        self.content = content
        self.note = note
    }
}

@Model
class Note {
    var bookID: UUID
    var highlightID: UUID
    var note: String
    
    init(bookID: UUID, highlightID: UUID, note: String) {
        self.bookID = bookID
        self.highlightID = highlightID
        self.note = note
    }
}
