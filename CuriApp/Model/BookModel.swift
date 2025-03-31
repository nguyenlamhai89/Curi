//
//  BookModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 14/3/25.
//

import SwiftUI
import SwiftData

class Book: Identifiable, Codable {
    let bookID: UUID = UUID()
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
    var bookTitle: String
    var highlight: String
    var note: Note?
    
    init (bookID: UUID, bookTitle: String, highlight: String) {
        self.bookID = bookID
        self.bookTitle = bookTitle
        self.highlight = highlight
    }
}

@Model
class Note {
    var bookID: UUID
    var note: String
    
    init (bookID: UUID, note: String) {
        self.bookID = bookID
        self.note = note
    }
}
