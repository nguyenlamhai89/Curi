//
//  QuotePapers.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 5/4/25.
//

import SwiftUI


struct QuotePaperGroup: View {
//    var connectedQuotesSample: [String] = ["Blow, blow, thou winter wind", "Thou art not so unkind", "As man's ingratitude;"]
    var connectedQuotesSample: [String] = []
    var quoteInPaper: String
    var authorInPaper: String
    var bookInPaper: String
    var paperAction: () -> Void
    
    var highlightContent: String
    var highlightColor: Color
    var highlightAction: () -> Void
    
    var body: some View {
        ZStack (alignment: .top) {
            HighlightQuotePaperButton(content: highlightContent, color: highlightColor) {
                highlightAction()
            }
            VStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 22)
                QuotePaper(connectedQuotesSample: connectedQuotesSample, quoteInPaper: quoteInPaper, authorInPaper: authorInPaper, bookInPaper: bookInPaper) {
                    print("Open Quote Paper")
                    paperAction()
                }
            }
        }
        
    }
}

struct QuotePaper: View {
    var connectedQuotesSample: [String]
    var quoteInPaper: String
    var authorInPaper: String
    var bookInPaper: String
    var action: () -> Void
    
    var body: some View {
        VStack (spacing: 0) {
            VStack (spacing: curiSpacing(.sp16)) {
                Text("Quote of the Day")
                    .curiTypo(.sfMedium14)
                    .foregroundStyle(curiPalette(.ink500))
                    .frame(maxWidth: .infinity)
//                    .background(Color.yellow) // Check section
                
                VStack (spacing: curiSpacing(.sp16)) {
                    Text("\(quoteInPaper)")
                        .curiTypo(.bkRegular32)
                        .foregroundStyle(curiPalette(.ink500))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    HStack (spacing: curiSpacing(.sp8)) {
                        Text(bookInPaper)
                            .foregroundStyle(curiPalette(.ink500))
                        Text(authorInPaper)
                            .foregroundStyle(curiPalette(.ink300))
                    }
                    .lineLimit(1)
                    .curiTypo(.sfMedium12)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(maxHeight: .infinity)
//                .background(Color.red) // Check section
            }
            .padding(curiSpacing(.sp16))
            .background(curiPalette(.paper500))
            
            if !connectedQuotesSample.isEmpty {
                VStack (spacing: 0) {
                    Divider()
                        .background(curiPalette(.ink100))
                    
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
                    }
                    .padding(curiSpacing(.sp16))
                    .background(curiPalette(.paper300))
        //                    .background(Color.red) // Check section
                }
            } else {
                EmptyView()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: curiRadius(.rd4)))
        .shadow(color: .black.opacity(0.16), radius: 8, x: 0, y: 4)
        .background(
            RoundedRectangle(cornerRadius: curiRadius(.rd4))
                .stroke(curiPalette(.ink100), lineWidth: 1)
        )
        .onTapGesture {
            action()
        }
        
    }
}

#Preview {
    QuotePaperGroup(quoteInPaper: "Quote quote quote", authorInPaper: "Author", bookInPaper: "Book name", paperAction: {
        print("Quote Paper Tapped")
    }, highlightContent: "Discuss Later", highlightColor: Color.red, highlightAction: {
        print("Highlight Button Rename")
    })
    .padding(24)
}
