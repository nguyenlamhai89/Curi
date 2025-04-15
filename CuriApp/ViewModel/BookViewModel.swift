//
//  BookViewModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 14/3/25.
//

import SwiftUI
import UIKit

@Observable
class BookViewModel {
    var bookDatabase: [Book] = []
//    @Query var pencilDatabase: [HighlightPencil] = []
    
//    func initDefaultPencils() {
//        guard pencilDatabase.isEmpty else { return }
//        var pencil1 = HighlightPencil(name: "Discuss Later",
//                                      primaryTextColor: "paper-500",
//                                      primaryBackgroundColor: "blue-300",
//                                      secondaryTextColor: "blue-500",
//                                      secondaryBackgroundColor: "blue-100",
//                                      highlightedTextColor: "blue-500",
//                                      defaultHighlightedBackgroundColor: "blue-100",
//                                      selectedHighlightedBackgroundColor: "blue-200")
//        var pencil2 = HighlightPencil(name: "Good Point",
//                                      primaryTextColor: "paper-500",
//                                      primaryBackgroundColor: "pink-300",
//                                      secondaryTextColor: "pink-500",
//                                      secondaryBackgroundColor: "pink-100",
//                                      highlightedTextColor: "pink-500",
//                                      defaultHighlightedBackgroundColor: "pink-100",
//                                      selectedHighlightedBackgroundColor: "pink-200")
//        modelContext.insert(pencil1)
//        modelContext.insert(pencil2)
//    }
//    
//    init(modelContext: ModelContext) {
//        self.modelContext = modelContext
//        initDefaultPencils()
//    }
    
    var selectedPen: HighlightPencil?
    
    var isLoading = true
    var isFetched = false
    
    // Get Book
    func fetchBooks() async throws {
        guard let url = URL(string: "https://poetrydb.org/author/William%20Shakespeare") else { throw
            URLError(.badURL) }
        do {
            isLoading = true
            isFetched = false
            
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
            isLoading = false
            isFetched = false
            
            print("Loading: \(isLoading) - Fetch Done: \(isFetched)")
            print("⚠️ Error: \(error)")
            throw error
        }
    }
}

//struct HighlightDemo: View {
//    @Environment(\.modelContext) private var modelContext
//    @State var viewModel = BookViewModel(modelContext: modelContext)
//    @State var demoHighlighted: AttributedString = "Demo Highlighted Text"
//    
//    var body: some View {
//        Text(demoHighlighted)
//            .curiTypo(.bkRegular16)
//    }
//}
//
//struct ViewModelTestView: View {
//    @Environment(\.modelContext) private var modelContext
//    @State private var viewModel = BookViewModel(modelContext: modelContext)
//    @State var isLoadingData: Bool = true
//    
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(viewModel.bookDatabase) { book in
//                    Text("\(book.author)")
//                }
//            }
//            .navigationTitle("ViewModel Test")
//            .task {
//                if viewModel.bookDatabase.isEmpty {
//                    try? await viewModel.fetchBooks()
//                    print("📚 \(viewModel.bookDatabase.count) books fetched")
//                } else {
//                    return
//                }
//            }
//        }
//        
//    }
//}

//#Preview {
//    HighlightDemo()
//}
