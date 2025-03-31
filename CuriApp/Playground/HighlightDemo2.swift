//
//  HighlightDemo2.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 31/3/25.
//

import SwiftUI

struct SimpleTapToHighlightView: View {
    let texts = [
        "SwiftUI is powerful.",
        "Learning by doing is effective.",
        "User experience matters.",
        "Keep it simple!"
    ]
    
    // Các đoạn đã được highlight
    @State private var highlightedTexts: [String] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Ấn giữ để highlight:")
                .font(.headline)
            
            // Danh sách các đoạn text có thể ấn giữ
            ForEach(texts, id: \.self) { text in
                Text(text)
                    .padding(8)
                    .background(highlightedTexts.contains(text) ? Color.yellow.opacity(0.5) : Color.clear)
                    .cornerRadius(8)
                    .onLongPressGesture {
                        if !highlightedTexts.contains(text) {
                            highlightedTexts.append(text)
                        }
                    }
            }
            
            Divider()
            
            Text("Đã highlight:")
                .font(.headline)
            ForEach(highlightedTexts, id: \.self) { item in
                Text(item)
                    .padding(6)
                    .background(Color.yellow.opacity(0.3))
                    .cornerRadius(6)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
//    @Previewable @State private var highlightedTexts: [String] = []
    SimpleTapToHighlightView()
}
