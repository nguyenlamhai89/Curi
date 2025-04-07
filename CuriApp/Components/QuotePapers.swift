//
//  QuotePapers.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 5/4/25.
//

import SwiftUI

struct QuotePapers: View {
    var connectedQuotesSample: [String] = ["Blow, blow, thou winter wind",
                                           "Thou art not so unkind",
                                           "As man's ingratitude;"]
    
    var quoteInPaper: String
    var authorInPaper: String
    var bookInPaper: String
    var buttonName: String
    var action: () -> Void
    
    var body: some View {
        // Quote Papers
        VStack (spacing: curiSpacing(.sp8)) {
            // Headlines
            HStack (spacing: curiSpacing(.sp8)) {
                VStack (spacing: 0) {
                    Text("Quote of the day")
                        .curiTypo(.sfMedium14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack (spacing: curiSpacing(.sp8)) {
                        Text(bookInPaper)
                            .foregroundStyle(curiPalette(.ink500))
                        Text(authorInPaper)
                            .foregroundStyle(curiPalette(.ink300))
                    }
                    .lineLimit(1)
                    .curiTypo(.sfMedium12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity)
//                .background(Color.yellow) // Check section
                
                HighlightTag(content: "Discuss Later")
            }
            .frame(maxWidth: .infinity)
//            .background(Color.red)
            
            // Content
            Text(quoteInPaper)
                .curiTypo(.bkRegular32)
                .foregroundStyle(curiPalette(.ink500))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .background(Color.red) // Check section
            
            HStack (spacing: curiSpacing(.sp8)) {
                Text("Connected")
                    .curiTypo(.sfMedium14)
                    .foregroundStyle(curiPalette(.ink500))
                Rectangle()
                    .fill(Color.clear)
                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
                .overlay {
                    ScrollView (.horizontal) {
                        HStack (spacing: curiSpacing(.sp8)) {
                            ForEach(connectedQuotesSample, id:\.self) { quote in
                                Button {
                                    print("Hihihi")
                                } label: {
                                    Text(quote)
                                        .curiTypo(.bkRegular14)
                                        .foregroundStyle(curiPalette(.paper500))
                                        .padding(.vertical, curiSpacing(.sp2))
                                        .padding(.horizontal, curiSpacing(.sp8))
                                        .frame(maxWidth: 160, alignment: .leading)
                                        .background(curiPalette(.ink300))
                                        .cornerRadius(curiRadius(.rd4))
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .safeAreaPadding(.horizontal, curiSpacing(.sp32))
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .overlay {
                    // Gradient Block
                    HStack {
                        LinearGradient(colors: [curiPalette(.paper300), curiPalette(.paper300).opacity(0)], startPoint: .leading, endPoint: .trailing)
                            .frame(width: 32)
                        Spacer()
                        LinearGradient(colors: [curiPalette(.paper300), curiPalette(.paper300).opacity(0)], startPoint: .trailing, endPoint: .leading)
                            .frame(width: 32)
                    }
                }
                .clipped()
                
//                TextButtonStroke(content: buttonName) {
//                    action()
//                }
            }
//                    .background(Color.red) // Check section
        }
        .padding(curiSpacing(.sp16))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(curiPalette(.paper300))
        .cornerRadius(curiRadius(.rd4))
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    QuotePapers(quoteInPaper: "A plaintful story from a sistering vale,", authorInPaper: "William Shakespeare", bookInPaper: "A Lover's Complaint", buttonName: "Details") {
        print("Details")
    }
}
