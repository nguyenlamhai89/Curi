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
    
    @Published var quoteChangedTrigger = UUID() // For Highlight color and Highlight name
    
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
    
    // Widget
    @AppStorage("widgetQuote", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var quoteOnWidget: String = ""
    @AppStorage("widgetAuthor", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var authorOnWidget: String = ""
    @AppStorage("widgetBook", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var bookOnWidget: String = ""
    @AppStorage("widgetHighlightName", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var highlightNameOnWidget: String = ""
    @AppStorage("widgetHighlightColor", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var highlightColorOnWidget: String = ""
    @AppStorage("lineNumOnWidget", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var lineNumOnWidget: Int?
    @AppStorage("lastQuoteUpdateDate", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var lastQuoteUpdateDate: Date?
    
    func shuffleQOTD(quoteDatabase: [Quote]) {
        
        let quoteRandomInDay = quoteDatabase.randomElement()
        quoteOnWidget = quoteRandomInDay?.quoteContent ?? ""
        authorOnWidget = quoteRandomInDay?.quoteAuthor ?? ""
        bookOnWidget = quoteRandomInDay?.quoteBook ?? ""
        highlightNameOnWidget = quoteRandomInDay?.quoteHighlight?.name ?? "Shuffle"
        highlightColorOnWidget = quoteRandomInDay?.quoteHighlight?.primaryBackgroundColor ?? "ink-500"
        lineNumOnWidget = quoteRandomInDay?.quoteLineNum
        
        lastQuoteUpdateDate = Date()
        print("Last Updated: \(String(describing: lastQuoteUpdateDate))")
        WidgetCenter.shared.reloadTimelines(ofKind: "curiWidget")
    }
    
    func checkQOTD(quoteDatabase: [Quote]) { // Kiểm tra mỗi khi HomeView xuất hiện
        // Nếu quoteDatabase trống -> lineNumOnWidget = -1 ("Read a book...)
        // Nếu có quoteDatabase -> 1) lineNumOnWidget = -1 thì sẽ shuffleQOTD() - 2) else return
//        let userDefaults = UserDefaults(suiteName: "group.madeby.nham.curiapp")
//        userDefaults?.synchronize()
        
        if !quoteDatabase.isEmpty {
            if lineNumOnWidget == -1 || lineNumOnWidget == -2 { // Blank or Out-dated
                shuffleQOTD(quoteDatabase: quoteDatabase)
                print("💳 Shuffled QOTD: \(quoteOnWidget) - \(highlightNameOnWidget) - \(highlightColorOnWidget)")
                print(" -- 1 -- ")
            } else {
                //When deleting QOTD
                if !quoteDatabase.contains(where: { $0.quoteContent == quoteOnWidget && $0.quoteLineNum == lineNumOnWidget }) {
                    shuffleQOTD(quoteDatabase: quoteDatabase)
                    print(" -- 2 -- ")
                }
                print("- Line num: \(String(describing: lineNumOnWidget))")
                print(" -- 3 -- ")
            }
        } else {
            quoteOnWidget = ""
            authorOnWidget = ""
            bookOnWidget = ""
            highlightNameOnWidget = ""
            highlightColorOnWidget = ""
            lineNumOnWidget = -1 // (Read a book and ...)
            print(" -- 4 -- ")
        }
        
        lastQuoteUpdateDate = Date()
        print("Last Updated: \(String(describing: lastQuoteUpdateDate))")
        WidgetCenter.shared.reloadTimelines(ofKind: "curiWidget")
        
        print("⭐️ Quote Of The Day: [\(String(describing: lineNumOnWidget))] \(quoteOnWidget) - \(highlightNameOnWidget) - \(highlightColorOnWidget)")
    }
    
    func updateQOTD(quoteDatabase: [Quote]) { // Xảy ra khi có thay đổi về quoteDatabase (thêm / xoá) và quoteChangeTriggerID
        checkQOTD(quoteDatabase: quoteDatabase)
        
        if let matchedQuote = quoteDatabase.first(where: { $0.quoteContent == quoteOnWidget && $0.quoteLineNum == lineNumOnWidget }) {
            quoteOnWidget = matchedQuote.quoteContent
            authorOnWidget = matchedQuote.quoteAuthor
            bookOnWidget = matchedQuote.quoteBook
            highlightNameOnWidget = matchedQuote.quoteHighlight?.name ?? "Update"
            highlightColorOnWidget = matchedQuote.quoteHighlight?.primaryBackgroundColor ?? "ink-100"
            lineNumOnWidget = matchedQuote.quoteLineNum
        } else {
            // Không còn thì shuffle mới
            checkQOTD(quoteDatabase: quoteDatabase)
        }
        
        lastQuoteUpdateDate = Date()
        print("Last Updated: \(String(describing: lastQuoteUpdateDate))")
        WidgetCenter.shared.reloadTimelines(ofKind: "curiWidget")
    }
    
}
