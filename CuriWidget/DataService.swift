//
//  DataService.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 10/3/25.
//

import Foundation
import SwiftUI

struct DataService {
    @AppStorage("sampleQuote", store: UserDefaults(suiteName: "group.madebynham.curi")) var widgetQuote: String = "Tôi khóc những chân trời không có người bay; Lại khóc những người bay không có chân trời"
    @AppStorage("sampleQuote", store: UserDefaults(suiteName: "group.madebynham.curi")) var widgetAuthor: String = "Trần Dần"
    @AppStorage("sampleQuote", store: UserDefaults(suiteName: "group.madebynham.curi")) var widgetBook: String = "Thơ mini"
    @AppStorage("sampleQuote", store: UserDefaults(suiteName: "group.madebynham.curi")) var widgetHighlight: String = "Discuss Later"
    
    func fetchContentQuote() -> String {
        return widgetQuote
    }
    
    func fetchAuthorQuote() -> String {
        return widgetAuthor
    }
    
    func fetchBookQuote() -> String {
        return widgetBook
    }
    
    func fetchHighlightQuote() -> String {
        return widgetHighlight
    }
}
