//
//  BookViewModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 14/3/25.
//

import SwiftUI
import UIKit

//@MainActor
//@Observable
class BookViewModel: ObservableObject {
    @AppStorage("firstTimeReading", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var firstTimeReading: Bool = true
    @AppStorage("firstTimeInAPp", store: UserDefaults(suiteName: "group.madeby.nham.curiapp")) var firstTimeInApp: Bool = true

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
            
            if let dataRaw = String(data: data, encoding: .utf8) {
                print("Raw JSON Response:", dataRaw)
            }
            
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
}
