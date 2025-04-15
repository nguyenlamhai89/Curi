//
//  BookViewModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 14/3/25.
//

import SwiftUI
import UIKit
import SwiftData

@Observable
class BookViewModel {
    
    var bookDatabase: [Book] = []
    
    var highlightPenStorage: [HighlightPen] = [
        HighlightPen(defaultName: "Discuss Later",
                     selectedTextColor: Color.paper500,
                     selectedBackgroundColor: Color.blue300,
                     unselectedTextColor: Color.blue500,
                     unselectedBackgroundColor: Color.blue100,
                     highlightedTextColor: Color.blue500,
                     unselectedHighlightedBackgroundColor: Color.blue100,
                     selectedHighlightedBackgroundColor: Color.blue200),
        HighlightPen(defaultName: "Good Point",
                     selectedTextColor: Color.paper500,
                     selectedBackgroundColor: Color.pink300,
                     unselectedTextColor: Color.pink500,
                     unselectedBackgroundColor: Color.pink100,
                     highlightedTextColor: Color.pink500,
                     unselectedHighlightedBackgroundColor: Color.pink100,
                     selectedHighlightedBackgroundColor: Color.pink200)
    ]
    
    var selectedPen: HighlightPen?
    
    var isLoading = true
    var isFetched = false
    
    // Get Book
    func fetchBooks() async throws {
        guard let url = URL(string: "https://poetrydb.org/author/William%20Shakespeare") else { throw
            URLError(.badURL) }
        do {
            isLoading = true
            isFetched = false
            
            // Check fetch status
//            guard !isFetched else { return }
            
            print("Loading: \(isLoading) - Fetch Done: \(isFetched)")
            
            // Run parallelly
//            async let sleepTask: Void = Task.sleep(nanoseconds: 1_600_000_000)
            async let dataTask: (Data, URLResponse) = URLSession.shared.data(from: url)
            
//            _ = try await sleepTask
            let (data, _) = try await dataTask
            
//            Run step-by-step
//            try? await Task.sleep(nanoseconds: 400_000_000)
//            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Raw JSON Dataâ
            if let dataRaw = String(data: data, encoding: .utf8) {
                print("Raw JSON Response:", dataRaw)
            }
            
            // Decoded JSON Data
            let dataDecoded = try JSONDecoder().decode([Book].self, from: data)
            await MainActor.run {
                isLoading = false
                isFetched = true
                self.bookDatabase = dataDecoded
            }
            
            print("Loading: \(isLoading) - Fetch Done: \(isFetched)")
            print("📚 \(bookDatabase.count) is successfully loaded!")
            
        } catch {
            isLoading = false
            isFetched = false
            
            print("Loading: \(isLoading) - Fetch Done: \(isFetched)")
            print("⚠️ Error: \(error)")
            throw error
        }
    }
}

struct HighlightDemo: View {
    @Bindable var viewModel = BookViewModel()
    @State var demoHighlighted: AttributedString = "Demo Highlighted Text"
    
    var body: some View {
        Text(demoHighlighted)
            .curiTypo(.bkRegular16)
    }
}

struct ViewModelTestView: View {
    @Bindable private var viewModel = BookViewModel()
    @State var isLoadingData: Bool = true
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.bookDatabase) { book in
                    Text("\(book.author)")
                }
            }
            .navigationTitle("ViewModel Test")
            .task {
                if viewModel.bookDatabase.isEmpty {
                    try? await viewModel.fetchBooks()
                    print("📚 \(viewModel.bookDatabase.count) books fetched")
                } else {
                    return
                }
            }
        }
        
    }
}

#Preview {
    HighlightDemo()
}
