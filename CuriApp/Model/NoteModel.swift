//
//  NoteModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 23/5/25.
//

import SwiftUI
import SwiftData

@Model
class Note {
    var noteID: UUID = UUID()
    var noteContent: String = ""
    var hasContent: Bool {
        !noteContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    init(noteContent: String = "") {
        self.noteContent = noteContent
    }
}
