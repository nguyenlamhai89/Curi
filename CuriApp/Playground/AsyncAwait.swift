//
//  AsyncAwait.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 15/3/25.
//

import SwiftUI

class AsyncAwaitViewModel: ObservableObject {
    @Published var dataArray: [String] = ["1", "2", "3", "4", "5"]
    
    func addDataMainThread() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("Current Thread: \(Thread.current)")
        }
    }
    
    func addNumber() async {
        await MainActor.run {
            let newNumber = "Number: \(Thread.current)"
            self.dataArray.append(newNumber)
        }
        
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        
        //        let newNumber2 = "Number2: \(Thread.current)"
        await MainActor.run {
            let newNumber2 = "Number2: \(Thread.current)"
            self.dataArray.append(newNumber2)
            
            let newNumber3 = "Number3: \(Thread.current)"
            self.dataArray.append(newNumber3)
        }
        
        await addSomething()
    }
    
    func addSomething() async {
        try? await Task.sleep(nanoseconds: 4_000_000_000)
        
        await MainActor.run {
            let newSomething = "Something: \(Thread.current)"
            self.dataArray.append(newSomething)
        }
    }
}

struct AsyncAwait: View {
    @StateObject var viewModel = AsyncAwaitViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.dataArray, id: \.self) { item in
                    Text(item)
                }
            }
            .navigationTitle("Async Await")
        }
        .onAppear {
//            viewModel.addDataMainThread()
            Task {
                await viewModel.addNumber()
            }
        }
    }
}

#Preview {
    AsyncAwait()
}
