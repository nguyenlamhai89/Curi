//
//  HighlightDemo.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 23/3/25.
//

import SwiftUI

struct HighlightedTextView: View {
    
    var quote: String = "A plaintful story from a sistering vale,"
    
    var body: some View {
        Text(makeHighlightedText(quote))
            .curiTypo(.sfMedium32)
            .foregroundStyle(curiPalette(.ink500))
            .padding()
    }

    func makeHighlightedText(_ quote: String) -> AttributedString {
        var fullText = AttributedString(quote)
        
        let range = fullText.startIndex..<fullText.endIndex
        fullText[range].backgroundColor = curiPalette(.blue100)
        fullText[range].foregroundColor = curiPalette(.blue500)
        
        //        if let range = fullText.range(of: fullText) {
        //            fullText[range].backgroundColor = curiPalette(.blue100)
        //            fullText[range].foregroundColor = curiPalette(.blue500)
        //        }
        
        return fullText
    }
}

#Preview {
    HighlightedTextView()
}
