//
//  WidgetDataManager.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 24/4/25.
//

import SwiftUI
import WidgetKit

class WidgetDataManager {
    @AppStorage("widgetQuote", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var quoteOnWidget: String = ""
    @AppStorage("widgetAuthor", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var authorOnWidget: String = ""
    @AppStorage("widgetBook", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var bookOnWidget: String = ""
    @AppStorage("widgetHighlightName", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var highlightNameOnWidget: String = ""
    @AppStorage("widgetHighlightColor", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var highlightColorOnWidget: String = ""
    
    func updateQuoteOnWidget(quoteDatabase: [Quote]) {
        guard let quote = quoteDatabase.first else {
            quoteOnWidget = ""
            authorOnWidget = ""
            bookOnWidget = ""
            highlightNameOnWidget = ""
            highlightColorOnWidget = ""
            return
        }
        quoteOnWidget = quote.quoteContent
        authorOnWidget = quote.quoteAuthor
        bookOnWidget = quote.quoteBook
        highlightNameOnWidget = quote.quoteHighlight?.name ?? "None"
        highlightColorOnWidget = quote.quoteHighlight?.primaryBackgroundColor ?? "ink-500"
        
        WidgetCenter.shared.reloadTimelines(ofKind: "curiWidget")
    }
}
