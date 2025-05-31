//
//  BookViewModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 14/3/25.
//

import SwiftUI
import SwiftData
import UIKit
import WidgetKit
import CloudKit

//@Observable
class BookViewModel: ObservableObject {
    /// Main app
    @AppStorage("firstTimeReading", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var firstTimeReading: Bool = true
    @AppStorage("firstTimeInAPp", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var firstTimeInApp: Bool = true
    @AppStorage("soundInApp", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var soundInApp: Bool = true
    @AppStorage("vibrationInApp", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var vibrationInApp: Bool = true
    
    /// Widget
    @AppStorage("widgetQuote", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var quoteOnWidget: String = ""
    @AppStorage("widgetAuthor", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var authorOnWidget: String = ""
    @AppStorage("widgetBook", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var bookOnWidget: String = ""
    @AppStorage("widgetHighlightName", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var highlightNameOnWidget: String = ""
    @AppStorage("widgetHighlightColor", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var highlightColorOnWidget: String = ""
    @AppStorage("lineNumOnWidget", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var lineNumOnWidget: Int?
    @AppStorage("lastQuoteUpdateDate", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var lastQuoteUpdateDate: Date?
    @Published var lastSyncedTime: Date = .distantPast

    /// Selected Highlight Pencil Status
    @Published var selectedPen: HighlightPencil?
    @Published var selectedIndex: Int = 0
    
    /// Data Fetching Status
    @Published var bookDatabase: [Book] = []
    @Published var isLoading = true
    @Published var isFetched = false
    
    /// Highlight Status
    @Published var selectedLine: Quote? = nil
    @Published var pageIsSelected: Bool = false
    @Published var quoteIsSelected: Bool = false
    
    /// Bottom Sheet Status
    @Published var quoteNoteSheetViewIsPresented: Bool = false
    @Published var deleteAlertIsPresented: Bool = false
    @Published var accessSheetFromBookView: Bool = false
    @Published var appIntroducingSheet: Bool = false
    
    /// Highlight Trigger
    @Published var quoteChangedTrigger = UUID() // For Highlight color and Highlight name
    
    @Published var quoteToDelete: Quote?
    
    /// Functions
    func getiCloudStatus() {
        CKContainer.default().accountStatus { status, error in
            DispatchQueue.main.async {
                switch status {
                case .available:
                    print("🌤️ Available to iCloud Sync! - Last sync: \(String(describing: self.lastSyncedTime))")
                case .couldNotDetermine:
                    print("🚫 Could Not Determine")
                case .noAccount:
                    print("🚫 No iCloud Account Found")
                case .restricted:
                    print("🚫 iCloud Restricted")
                default:
                    break
                }
            }
        }
    }
    
    func checkFirstTimeInApp() {
        if !firstTimeInApp {
            return
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.appIntroducingSheet = true
            }
        }
    }
    
    func getUserSettings(userSettings: [User], modelContext: ModelContext) {
        if userSettings.isEmpty {
            let thisUser = User(totalReadTime: 0, soundInApp: soundInApp, vibrationInApp: vibrationInApp)
            modelContext.insert(thisUser)
            try? modelContext.save()
            lastSyncedTime = Date()
            print("--- User Settings: \(userSettings)")
        } else {
            print("✅ User Settings: \(userSettings)")
        }
    }
    
    func getHighlightPencils(pencilDatabase: [HighlightPencil], modelContext: ModelContext) {
        let pencilLibrary: [HighlightPencil] = [
            HighlightPencil(
                name: "Discuss Later",
                primaryTextColor: "paper-500",
                primaryBackgroundColor: "blue-300",
                isPresentedRenameView: false,
                secondaryTextColor: "blue-500",
                secondaryBackgroundColor: "blue-100",
                highlightedTextColor: "blue-500",
                defaultHighlightedBackgroundColor: "blue-100",
                selectedHighlightedBackgroundColor: "blue-200"
            ),
            HighlightPencil(
                name: "Good Point",
                primaryTextColor: "paper-500",
                primaryBackgroundColor: "pink-300",
                isPresentedRenameView: false,
                secondaryTextColor: "pink-500",
                secondaryBackgroundColor: "pink-100",
                highlightedTextColor: "pink-500",
                defaultHighlightedBackgroundColor: "pink-100",
                selectedHighlightedBackgroundColor: "pink-200"
            )
        ]
        
        if pencilDatabase.isEmpty {
            for insertPencil in pencilLibrary {
                modelContext.insert(insertPencil)
            }
        } else {
            for index in pencilDatabase.indices {
                let pencilOld = pencilDatabase[index]
                let pencilNew = pencilLibrary[index]
                
                //                    pencilOld.name = pencilNew.name
                pencilOld.primaryTextColor = pencilNew.primaryTextColor
                pencilOld.primaryBackgroundColor = pencilNew.primaryBackgroundColor
                pencilOld.secondaryTextColor = pencilNew.secondaryTextColor
                pencilOld.secondaryBackgroundColor = pencilNew.secondaryBackgroundColor
                pencilOld.highlightedTextColor = pencilNew.highlightedTextColor
                pencilOld.defaultHighlightedBackgroundColor = pencilNew.defaultHighlightedBackgroundColor
                pencilOld.selectedHighlightedBackgroundColor = pencilNew.selectedHighlightedBackgroundColor
            }
        }
        
        try? modelContext.save()
        
        if selectedPen == nil {
            selectedPen = pencilDatabase.first
        }
    }
    
    func checkSelectedLine(quoteDatabase: [Quote], quote: Quote) {
        withAnimation {
            if let existingQuote = quoteDatabase.first(where: { $0.quoteContent == quote.quoteContent && $0.quoteLineNum == quote.quoteLineNum }) {
                if selectedLine?.quoteLineNum == existingQuote.quoteLineNum {
                    selectedLine = nil
                } else {
                    selectedLine = existingQuote
                }
            } else {
                selectedLine = nil
            }
            pageIsSelected = true
        }
        print("-- Ready to add Note: \(selectedLine != nil ? "✅" : "🙅🏻‍♂️") - \(String(describing: selectedLine?.quoteContent)), \(String(describing: selectedLine?.quoteHighlight?.name ?? ""))")
        print("\(quote.quoteLineNum)) - \(quote.quoteContent)")
    }
    
    func checkQuoteDatabase(quoteDatabase: [Quote], checkingQuote: Quote, modelContext: ModelContext) {
        if let existingQuote = quoteDatabase.first(where: { $0.quoteContent == checkingQuote.quoteContent && $0.quoteLineNum == checkingQuote.quoteLineNum }) {
            if existingQuote.quoteNote?.hasContent == true {
                quoteToDelete = existingQuote
                print("\(String(describing: quoteToDelete))")
                print("Display Alert!!!")
            } else {
                HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: vibrationInApp)
                SoundManager.access.play(sound: .highlightRemoved, soundEnabledInApp: soundInApp)
                modelContext.delete(existingQuote)
                selectedLine = nil
                print("Not Display Alert!!!")
            }
        } else {
            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: vibrationInApp)
            SoundManager.access.play(sound: .highlightAdded, soundEnabledInApp: soundInApp)
            checkingQuote.quoteHighlight = selectedPen
            modelContext.insert(checkingQuote)
        }
        lastSyncedTime = Date()
    }
    
    func connectQuotes(isConnected: Bool, quote: Quote, quoteConnecting: Quote) {
        if isConnected {
            quote.connectedQuotes?.removeAll(where: { $0.quoteID == quoteConnecting.quoteID })
            quoteConnecting.connectedQuotes?.removeAll(where: { $0.quoteID == quote.quoteID })
        } else {
            quote.connectedQuotes?.append(quoteConnecting)
            quoteConnecting.connectedQuotes?.append(quote)
        }
        lastSyncedTime = Date()
        print("[\(quote.isConnected ? "✅" : "🙅🏼")] - \(quote.quoteAddedDate) Connected With: \(String(describing: quote.connectedQuotes))")
        print("[\(quoteConnecting.isConnected ? "✅" : "🙅🏼")] - \(quoteConnecting.quoteAddedDate) - Connected With: \(String(describing: quoteConnecting.connectedQuotes))")
    }
    
    func deleteQuoteInSheet(quoteDatabase: [Quote], quote: Quote, modelContext: ModelContext) {
        if let quoteIsPresented = quoteDatabase.first(where: { $0.quoteContent == quote.quoteContent}) {
            modelContext.delete(quoteIsPresented)
//            presentationMode.wrappedValue.dismiss()
            lastSyncedTime = Date()
            print("Deleted!")
        }
    }
    
    func deleteQuoteInBook(modelContext: ModelContext, quoteOnDelete: Quote) {
        modelContext.delete(quoteOnDelete)
        selectedLine = nil
        lastSyncedTime = Date()
    }
    
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
        guard let lineNumOnWidgetFromWidget = UserDefaults(suiteName: "group.madeby.nham.curiapp")?.integer(forKey: "lineNumOnWidget") else {
            return
        }
        lineNumOnWidget = lineNumOnWidgetFromWidget
        
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
                print("- New Line num: \(String(describing: lineNumOnWidget))")
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
