//
//  DoTryCatchThrows.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 15/3/25.
//

import SwiftUI

class DoTryCatchThrowsDataManager {
    
    var isActive: Bool = false
    
    func getNewTextSample() throws -> String {
        if isActive {
            return "Updated Text Sample With Throws"
        } else {
            throw URLError(.badServerResponse)
        }
    }
}

class DoTryCatchThrowsViewModel: ObservableObject {
    @Published var initialTextSample = "Hello World"
    let dataManager = DoTryCatchThrowsDataManager()
    
    func updateTextSample() {
        do {
            let updateTextSample = try dataManager.getNewTextSample()
            self.initialTextSample = updateTextSample
        } catch {
            self.initialTextSample = error.localizedDescription
        }
    }
}

struct DoTryCatchThrows: View {
    @StateObject private var viewModel = DoTryCatchThrowsViewModel()
    
    var body: some View {
        Text(viewModel.initialTextSample)
            .onTapGesture {
                viewModel.updateTextSample()
            }
    }
}

#Preview {
    DoTryCatchThrows()
}
