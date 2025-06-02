//
//  HighlightPencilModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 23/5/25.
//

import SwiftUI
import SwiftData

@Model
class HighlightPencil {
    var pencilID: UUID = UUID()
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
    
    // Inversed with Quote: quoteHighlight
    var highlightQuote: [Quote]? = nil
    // Inversed with User: pencilDatabase
    var userPencilDatabase: User? = nil
    
    init(name: String, primaryTextColor: String, primaryBackgroundColor: String, secondaryTextColor: String, secondaryBackgroundColor: String, highlightedTextColor: String, defaultHighlightedBackgroundColor: String, selectedHighlightedBackgroundColor: String) {
        self.name = name
        self.primaryTextColor = primaryTextColor
        self.primaryBackgroundColor = primaryBackgroundColor
        self.secondaryTextColor = secondaryTextColor
        self.secondaryBackgroundColor = secondaryBackgroundColor
        self.highlightedTextColor = highlightedTextColor
        self.defaultHighlightedBackgroundColor = defaultHighlightedBackgroundColor
        self.selectedHighlightedBackgroundColor = selectedHighlightedBackgroundColor
    }
}

extension HighlightPencil: CustomStringConvertible {
    var description: String {
        return """
        --- Pencil(
            name: \(name),
            main color: \"\(primaryTextColor)\"
        )
        """
    }
}
