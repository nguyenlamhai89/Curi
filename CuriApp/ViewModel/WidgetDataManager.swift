//
//  WidgetDataManager.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 24/4/25.
//

import SwiftUI
import WidgetKit

class WidgetDataManager {
    static let access = WidgetDataManager()
    
    @AppStorage("widgetQuote", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var quoteOnWidget: String = ""
    @AppStorage("widgetAuthor", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var authorOnWidget: String = ""
    @AppStorage("widgetBook", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var bookOnWidget: String = ""
    @AppStorage("widgetHighlightName", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var highlightNameOnWidget: String = ""
    @AppStorage("widgetHighlightColor", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var highlightColorOnWidget: String = ""
    
    func updateQuoteOnWidget(quoteDatabase: [Quote]) {
        
        if !quoteDatabase.isEmpty {
            if let quoteRandom = quoteDatabase.randomElement() {
                quoteOnWidget = quoteRandom.quoteContent
                authorOnWidget = quoteRandom.quoteAuthor
                bookOnWidget = quoteRandom.quoteBook
                highlightNameOnWidget = quoteRandom.quoteHighlight?.name ?? "Default"
                highlightColorOnWidget = quoteRandom.quoteHighlight?.primaryBackgroundColor ?? "ink-500"
                print("🔥 Quote on Widget: \(quoteRandom)")
            }
        } else {
            quoteOnWidget = ""
        }
        
        WidgetCenter.shared.reloadTimelines(ofKind: "curiWidget")
    }
}
