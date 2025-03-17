//
//  AsyncLet.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 17/3/25.
//

import SwiftUI

struct AsyncLet: View {
    @State private var images: [UIImage] = []
    let url = URL(string: "https://picsum.photos/200")!
    
    var body: some View {
        NavigationView {
            List {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160)
                }
            }
            .navigationTitle("Async List")
            .onAppear {
                Task {
                    do {
                        async let fetchImage = fetchImage()
                        let image = try await fetchImage
                        self.images.append(image)
                    } catch {
                        
                    }
                }
            }
        }
    }
    
    func fetchTitle() async -> String {
        return "Title Fetched"
    }
    
    func fetchImage() async throws -> UIImage {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
            
        } catch {
            throw error
        }
    }
}

#Preview {
    AsyncLet()
}
