//
//  BookViewModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 14/3/25.
//

import SwiftUI
import UIKit

class BookViewModel: ObservableObject {
    
    @Published var booksDatabase: [Book] = []
    @Published var highlightDatabase: [AttributedString] = []
    
    var hasFetched = false
    
    func highlightChecker(for highlight: AttributedString, highlightColor: Color, textColor: Color) -> AttributedString {
        if let index = highlightDatabase.firstIndex(where: { $0.description == highlight.description }) {
                var initialText = highlightDatabase[index]
            
                let range = initialText.startIndex..<initialText.endIndex
                initialText[range].backgroundColor = nil
                initialText[range].foregroundColor = nil
            
                highlightDatabase.remove(at: index)
                
                HapticsManager.access.play(haptics: .light)
                SoundManager.access.play(sound: .highlightRemoved)
            
                print("🗑 Highlight removed. Total: \(highlightDatabase.count)")
                return initialText
            
            } else {
                var newText = highlight
                
                let range = newText.startIndex..<newText.endIndex
                newText[range].backgroundColor = highlightColor
                newText[range].foregroundColor = textColor
                
                highlightDatabase.append(newText)
                
                HapticsManager.access.play(haptics: .light)
                SoundManager.access.play(sound: .highlightAdded)
                
                print("✅ Highlight added. Total: \(highlightDatabase.count)")
                
                return newText
            }
    }
    
    // Get Book
    func fetchBooks() async throws {
        guard let url = URL(string: "https://poetrydb.org/author/William%20Shakespeare") else { throw URLError(.badURL) }
        do {
            // Check fetch status
            guard !hasFetched else { return }
            hasFetched = true
            
            print("Getting Data...")
            try? await Task.sleep(nanoseconds: 1_600_000_000)
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Raw JSON Dataâ
            if let dataRaw = String(data: data, encoding: .utf8) {
                print("Raw JSON Response:", dataRaw)
            }
            
            // Decoded JSON Data
            let dataDecoded = try JSONDecoder().decode([Book].self, from: data)
            await MainActor.run {
                self.booksDatabase = dataDecoded
            }
            
        } catch {
            throw error
        }
    }
}

struct HighlightDemo: View {
    @StateObject var viewModel = BookViewModel()
    @State var demoHighlighted: AttributedString = "Demo Highlighted Text"
    
    var body: some View {
        Text(demoHighlighted)
            .curiTypo(.bkRegular16)
            .onTapGesture {
                let highlightedText = viewModel.highlightChecker(for: demoHighlighted, highlightColor: curiPalette(.blue100), textColor: curiPalette(.blue500))
                demoHighlighted = highlightedText
            }
    }
}

struct ViewModelTestView: View {
    @StateObject private var viewModel = BookViewModel()
    @State var isLoadingData: Bool = true
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.booksDatabase) { book in
                    Text("\(book.author)")
                }
            }
            .navigationTitle("ViewModel Test")
            .task {
                if viewModel.booksDatabase.isEmpty {
                    try? await viewModel.fetchBooks()
                    print("📚 \(viewModel.booksDatabase.count) books fetched")
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
