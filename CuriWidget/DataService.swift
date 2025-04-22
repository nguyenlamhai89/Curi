//
//  DataService.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 10/3/25.
//

import Foundation
import SwiftUI
import SwiftData

struct DataService {
    @AppStorage("sampleQuote", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var widgetQuote: String = "Tôi khóc những chân trời không có người bay; Lại khóc những người bay không có chân trời"
    @AppStorage("sampleQuote", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var widgetAuthor: String = "Trần Dần"
    @AppStorage("sampleQuote", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var widgetBook: String = "Thơ mini"
    @AppStorage("sampleQuote", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var widgetHighlightName: String = "Discuss Later"
    @AppStorage("sampleQuote", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var widgetHighlightColor: String = "blue-300"
    
//    @Query var quoteDatabase: [Quote]
    
    func fetchContentQuote() -> String {
        return widgetQuote
    }
    
    func fetchAuthorQuote() -> String {
        return widgetAuthor
    }
    
    func fetchBookQuote() -> String {
        return widgetBook
    }
    
    func fetchHighlightName() -> String {
        return widgetHighlightName
    }
    
    func fetchHighlightColor() -> Color {
        return Color(widgetHighlightColor)
    }
    
//    func saveWidgetDatabase() {
//        WidgetCenter.shared.reloadAllTimelines()
//    }
}
