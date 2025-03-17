//
//  Task.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 17/3/25.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    
    func fetchImage() async {
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            self.image = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct TaskAsync: View {
    @StateObject var viewModel = TaskViewModel()
    
    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
            }
        }
        .task {
            await viewModel.fetchImage()
        }
//        .onAppear {
//            Task(priority: .low) {
//                print("Low: \(Thread.current))")
//                await viewModel.fetchImage()
//            }
//            Task(priority: .medium) {
//                print("Medium: \(Thread.current))")
//                await viewModel.fetchImage()
//            }
//            Task(priority: .high) {
//                print("High: \(Thread.current))")
//                await viewModel.fetchImage()
//            }
//        }
    }
}

#Preview {
    TaskAsync()
}
