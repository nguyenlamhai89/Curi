//
//  QuotePapers.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 5/4/25.
//

import SwiftUI

struct QuotePapers: View {
    var quoteInPaper: String
    var authorInPaper: String
    var bookInPaper: String
    var buttonName: String
    var action: () -> Void
    
    var body: some View {
        // Quote Papers
        ZStack {
            Rectangle()
                .fill(curiPalette(.paper500))
                .frame(width: 240, height: 360)
                .cornerRadius(curiRadius(.rd4))
                .shadow(color: .black.opacity(0.16), radius: 8, x: 0, y: 4)
                .rotationEffect(Angle(degrees: -6))
            
            VStack (spacing: curiSpacing(.sp8)) {
                Text(quoteInPaper)
                    .curiTypo(.bkRegular16)
                    .foregroundStyle(curiPalette(.ink500))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
    //                        .background(Color.red) // Check section
                HStack (spacing: curiSpacing(.sp8)) {
                    VStack (alignment: .leading, spacing: 0) {
                        Text(bookInPaper)
                            .foregroundStyle(curiPalette(.ink500))
                        Text(authorInPaper)
                            .foregroundStyle(curiPalette(.ink300))
                    }
                    .lineLimit(1)
                    .curiTypo(.sfMedium12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    TextButtonStroke(content: buttonName) {
                        action()
                    }
                }
    //                    .background(Color.red) // Check section
            }
            .padding(curiSpacing(.sp16))
            .frame(width: 240, height: 360)
            .background(curiPalette(.paper500))
            .cornerRadius(curiRadius(.rd4))
            .shadow(color: .black.opacity(0.16), radius: 8, x: 0, y: 4)
        }
    }
}

#Preview {
    QuotePapers(quoteInPaper: "A plaintful story from a sistering vale,", authorInPaper: "William Shakespeare", bookInPaper: "A Lover's Complaint", buttonName: "Details") {
        print("Details")
    }
}
