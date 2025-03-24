//
//  WordSeparate.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 22/3/25.
//

import SwiftUI

class SentenceViewModel: ObservableObject {
    @Published var sentence1: String = "FROM off a hill whose concave womb reworded"
    @Published var sentence2: String = "A plaintful story from a sistering vale,"
    
    @Published var separatedWords: [String] = []
    
    func separateWordFromSentence() {
        let words1 = sentence1.components(separatedBy: " ")
        let words2 = sentence2.components(separatedBy: " ")
        print(words1)
        print(words2)
        separatedWords.append(contentsOf: words1+words2)
    }
}

struct WordSeparate: View {
    
    @StateObject var textViewModel = SentenceViewModel()
    
    var body: some View {
        VStack (spacing: 4) {
            Text("Full")
                .curiTypo(.sfMedium12)
                .padding(4)
                .background(curiPalette(.blue100))
                .foregroundStyle(curiPalette(.blue500))
                .cornerRadius(4)
            Text(textViewModel.sentence1)
                .curiTypo(.bkRegular16)
                .onLongPressGesture(minimumDuration: 0.3) {
                            print("Long press ended on: \(textViewModel.sentence1)")
                            // Gọi hành động gì đó ở đây (ví dụ: thêm vào danh sách highlight)
                        }
            Text(textViewModel.sentence2)
                .curiTypo(.bkRegular16)
                .onLongPressGesture(minimumDuration: 0.3) {
                            print("Long press ended on: \(textViewModel.sentence2)")
                            // Gọi hành động gì đó ở đây (ví dụ: thêm vào danh sách highlight)
                        }
        }
        
        VStack (spacing: 4) {
            Text("Separated")
                .curiTypo(.sfMedium12)
                .padding(4)
                .background(curiPalette(.pink100))
                .foregroundStyle(curiPalette(.pink500))
                .cornerRadius(4)
            VStack {
                ForEach(textViewModel.separatedWords, id: \.self) { word in
                    Text(word)
                        .curiTypo(.bkRegular16)
                        .onLongPressGesture(minimumDuration: 0.3) {
                                    print("Long press ended on: \(word)")
                                    // Gọi hành động gì đó ở đây (ví dụ: thêm vào danh sách highlight)
                                }
                }
            }
                
        }
        
        Button {
            textViewModel.separateWordFromSentence()
        } label: {
            Text("Separate")
        }

    }
}

#Preview {
    WordSeparate()
}
