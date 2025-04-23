//
//  DataService.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 10/3/25.
//

import Foundation
import SwiftUI

struct DataService {
    @AppStorage("widgetQuote", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var quoteOnWidget: String = ""
    @AppStorage("widgetAuthor", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var authorOnWidget: String = ""
    @AppStorage("widgetBook", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var bookOnWidget: String = ""
    @AppStorage("widgetHighlightName", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var highlightNameOnWidget: String = ""
    @AppStorage("widgetHighlightColor", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var highlightColorOnWidget: String = ""
    
    
    func fetchContentQuote() -> String {
        return quoteOnWidget
    }
    
    func fetchAuthorQuote() -> String {
        return authorOnWidget
    }
    
    func fetchBookQuote() -> String {
        return bookOnWidget
    }
    
    func fetchHighlightName() -> String {
        return highlightNameOnWidget
    }
    
    func fetchHighlightColor() -> Color {
        return Color(highlightColorOnWidget)
    }
    
//    func saveWidgetDatabase() {
//        WidgetCenter.shared.reloadAllTimelines()
//    }
}
