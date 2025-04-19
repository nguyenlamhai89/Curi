//
//  QuotePapers.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 5/4/25.
//

import SwiftUI


struct QuotePaperGroup: View {
    var highlight: HighlightPencil
    var quote: Quote
    
    var quoteContent: String
    var quoteAuthor: String
    var quoteBook: String
    var paperAction: () -> Void

    var highlightAction: () -> Void
    
    var body: some View {
        ZStack (alignment: .top) {
            HighlightQuotePaperButton(content: highlight.name, color: Color(highlight.primaryBackgroundColor)) {
                highlightAction()
            }
            VStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 22)
                QuotePaper(quote: quote, quoteContent: quoteContent, quoteAuthor: quoteAuthor, quoteBook: quoteBook) {
                    print("Open Quote Paper")
                    paperAction()
                }
            }
        }
        
    }
}

struct QuotePaper: View {
    var quote: Quote
    var quoteContent: String
    var quoteAuthor: String
    var quoteBook: String
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
                    Text("\"\(quoteContent)\"")
                        .curiTypo(.bkRegular32)
                        .foregroundStyle(curiPalette(.ink500))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    HStack (spacing: curiSpacing(.sp8)) {
                        Text(quoteBook)
                            .foregroundStyle(curiPalette(.ink500))
                        Text(quoteAuthor)
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
            
            if !(quote.connectedQuotes?.isEmpty ?? true) {
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
                                    ForEach(quote.connectedQuotes ?? []) { quote in
                                        Button {
                                            print("-- From \(quote.quoteBook): \(quote.quoteContent)")
                                        } label: {
                                            Text(quote.quoteContent)
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
