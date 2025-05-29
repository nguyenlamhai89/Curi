//
//  UserModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 23/5/25.
//

import SwiftUI
import SwiftData

@Model
class User {
    var userID: UUID = UUID()
    var totalReadTime: Double = 0
    var soundInApp: Bool = true
    var vibrationInApp: Bool = true
    
    @Relationship(inverse: \Quote.userQuoteDatabase)
    var quoteDatabase: [Quote]? = nil
    
    @Relationship(inverse: \HighlightPencil.userPencilDatabase)
    var pencilDatabase: [HighlightPencil]? = nil
    
    init(totalReadTime: Double, soundInApp: Bool, vibrationInApp: Bool, quoteDatabase: [Quote]? = nil, pencilDatabase: [HighlightPencil]? = nil) {
        self.totalReadTime = totalReadTime
        self.soundInApp = soundInApp
        self.vibrationInApp = vibrationInApp
        self.quoteDatabase = quoteDatabase
        self.pencilDatabase = pencilDatabase
    }
}
