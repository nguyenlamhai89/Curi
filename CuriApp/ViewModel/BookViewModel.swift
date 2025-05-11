//
//  BookViewModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 14/3/25.
//

import SwiftUI
import UIKit
import WidgetKit

//@MainActor
//@Observable
class BookViewModel: ObservableObject {
    // Main app
    @AppStorage("firstTimeReading", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var firstTimeReading: Bool = true
    @AppStorage("firstTimeInAPp", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var firstTimeInApp: Bool = true
    @AppStorage("soundInApp", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var soundInApp: Bool = true
    @AppStorage("vibrationInApp", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var vibrationInApp: Bool = true
    
    // Widget
    @AppStorage("widgetQuote", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var quoteOnWidget: String = ""
    @AppStorage("widgetAuthor", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var authorOnWidget: String = ""
    @AppStorage("widgetBook", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var bookOnWidget: String = ""
    @AppStorage("widgetHighlightName", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var highlightNameOnWidget: String = ""
    @AppStorage("widgetHighlightColor", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var highlightColorOnWidget: String = ""

    @Published var bookDatabase: [Book] = []
    
    @Published var selectedIndex: Int = 0
    @Published var selectedPen: HighlightPencil?
    
    @Published var isLoading = true
    @Published var isFetched = false
    
    @Published var pageIsSelected: Bool = false
    @Published var quoteIsSelected: Bool = false
    
    @Published var quoteNoteSheetViewIsPresented: Bool = false
    @Published var deleteAlertIsPresented: Bool = false
    
    @Published var selectedLine: Quote? = nil
        
    @Published var accessSheetFromBookView: Bool = false
    
    @Published var quoteChangedTrigger = UUID() // Highlight color and Highlight name included
    
    // Get Book
    func fetchBooks() async throws {
        guard let url = URL(string: "https://poetrydb.org/author/William%20Shakespeare") else { throw
            URLError(.badURL) }
        do {
            await MainActor.run {
                isLoading = true
                isFetched = false
            }
            
            print("Loading: \(isLoading) - Fetch Done: \(isFetched)")
            
            async let dataTask: (Data, URLResponse) = URLSession.shared.data(from: url)
            
            let (data, _) = try await dataTask
            
//            if let dataRaw = String(data: data, encoding: .utf8) {
//                print("Raw JSON Response:", dataRaw)
//            }
            
            let dataDecoded = try JSONDecoder().decode([Book].self, from: data)
            await MainActor.run {
                isLoading = false
                isFetched = true
                self.bookDatabase = dataDecoded
            }
            
            print("Loading: \(isLoading) - Fetch Done: \(isFetched)")
            print("📚 \(bookDatabase.count) is successfully loaded!")
            
        } catch {
            await MainActor.run {
                isLoading = false
                isFetched = false
            }
            
            print("Loading: \(isLoading) - Fetch Done: \(isFetched)")
            print("⚠️ Error: \(error)")
            throw error
        }
    }
    
    // Update widget
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
