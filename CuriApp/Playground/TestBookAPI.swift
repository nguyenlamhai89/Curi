//
//  AsyncTestAPI.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 17/3/25.
//

import SwiftUI

struct BookModel: Codable, Identifiable {
    let id: UUID = UUID()
    let title: String
    let author: String
    let lines: [String]
    let linecount: String
}

class AsyncViewModel: ObservableObject {
    @Published var books: [BookModel] = []
    
    func fetchBookData() async throws {
        let url = URL(string: "https://poetrydb.org/author,title/Shakespeare;Sonnet")!
        try await Task.sleep(nanoseconds: 2_000_000_000)
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let bookData = try JSONDecoder().decode([BookModel].self, from: data)
            self.books = bookData
            books.sort { $0.title < $1.title }
        } catch {
            throw error
        }
    }
}

struct AsyncTestAPI: View {
    @StateObject private var viewModel = AsyncViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.books) { book in
                    NavigationLink {
                        VStack {
                            Spacer()
                            ForEach(book.lines, id: \.self) { line in
                                Text(line)
                                    .font(.system(size: 20, weight: .regular))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            Spacer()
                        }
                        .navigationTitle(book.title)
                        .navigationBarTitleDisplayMode(.inline)
                        .padding(.horizontal, 16)
                    } label: {
                        HStack (spacing: 8) {
                            Text(book.linecount)
                                .font(.system(size: 14, weight: .regular))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.1))
                                .foregroundStyle(Color.accentColor)
                                .cornerRadius(4)
                            VStack {
                                Text(book.title)
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(book.author)
                                    .font(.system(size: 14, weight: .regular))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Async Book")
            .task {
                try? await viewModel.fetchBookData()
            }
        }
    }
}

#Preview {
    AsyncTestAPI()
}
