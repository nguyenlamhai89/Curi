//
//  QuoteCard.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI

struct QuoteCardNavigation: View {
    var bookName: String
    var authorName: String
    var quoteContent: String
    var highlightTagName: String
    
    var body: some View {
        NavigationLink {
            Text("Quote and Note of \(bookName)")
        } label: {
            VStack (spacing: curiSpacing(.sp8)) {
                /// Book Info and Navigation
                HStack (spacing: curiSpacing(.sp4)) {
                    VStack (alignment: .leading) {
                        Text(bookName)
                            .foregroundStyle(curiPalette(.ink500))
                        Text(authorName)
                            .foregroundStyle(curiPalette(.ink300))
                    }
                    .curiTypo(.sfMedium12)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    IconButtonApp(iconName: "curiRight")
                }
                
                /// Quote
                Text("\(quoteContent)")
                    .curiTypo(.bkRegular16)
                    .foregroundStyle(curiPalette(.ink500))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                
                /// Highlight Tag
                Text(highlightTagName)
                    .curiTypo(.sfMedium14)
                    .foregroundStyle(curiPalette(.paper500))
                    .padding(.vertical, curiSpacing(.sp2))
                    .padding(.horizontal, curiSpacing(.sp8))
                    .background(curiPalette(.blue300))
                    .cornerRadius(curiRadius(.rd4))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(curiSpacing(.sp16))
            .background(curiPalette(.paper300))
            .cornerRadius(curiRadius(.rd8))
        }

    }
}

#Preview {
    QuoteCardNavigation(bookName: "Animal Farm", authorName: "George Orwell", quoteContent: "All that year the animals worked like slaves. But they were happy in their work; they grudged no effort or sacrifice, well aware that everything they did was for the benefit of themselves and those of their kind who would come after them, and not for a pack of idle, thieving human beings.", highlightTagName: "Discuss Later")
}
