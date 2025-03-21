//
//  BookViewModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 14/3/25.
//

import SwiftUI

class BookViewModel: ObservableObject {
    
    @Published var books: [Book] = []
    private var hasFetched = false
    
    func fetchBooks() async throws {
        guard let url = URL(string: "https://poetrydb.org/author/William%20Shakespeare") else { throw URLError(.badURL) }
        do {
            // Check fetch status
            guard !hasFetched else { return }
            hasFetched = true
            
            print("Getting Data...")
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Raw JSON Data
            if let dataRaw = String(data: data, encoding: .utf8) {
                print("Raw JSON Response:", dataRaw)
            }
            
            // Decoded JSON Data
            let dataDecoded = try JSONDecoder().decode([Book].self, from: data)
            await MainActor.run {
                self.books = dataDecoded
            }
            
        } catch {
            throw error
        }
    }
}

struct ViewModelTestView: View {
    @StateObject private var viewModel = BookViewModel()
    @State var isLoadingData: Bool = true
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.books) { book in
                    Text("\(book.author)")
                }
            }
            .navigationTitle("ViewModel Test")
            .task {
                if viewModel.books.isEmpty {
                    try? await viewModel.fetchBooks()
                    print("📚 \(viewModel.books.count) books fetched")
                } else {
                    return
                }
                
            }
        }
        
    }
}

#Preview {
    ViewModelTestView()
}
