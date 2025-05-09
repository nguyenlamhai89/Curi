//
//  QuoteCard.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI

struct QuoteCard: View {
    @ObservedObject var bookViewModel: BookViewModel
    var quoteBook: String
    var quoteAuthor: String
    var quoteContent: String
    var quoteHighlightName: String
    var quoteHighlightColor: String
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
            action()
        } label: {
            VStack (spacing: curiSpacing(.sp8)) {
                /// Book Info and Navigation
                VStack (alignment: .leading) {
                    Text(quoteBook)
                        .foregroundStyle(curiPalette(.ink500))
                    Text(quoteAuthor)
                        .foregroundStyle(curiPalette(.ink300))
                }
                .curiTypo(.sfMedium12)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                /// Quote
                Text("\"\(quoteContent)\"")
                    .curiTypo(.bkRegular16)
                    .foregroundStyle(curiPalette(.ink500))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                
                /// Highlight Tag
                HighlightTag(highlightName: quoteHighlightName, highlightColor: quoteHighlightColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(curiSpacing(.sp16))
            .background(curiPalette(.paper300))
            .cornerRadius(curiRadius(.rd8))
        }

    }
}

struct QuoteCardWithCheckbox: View {
    @ObservedObject var bookViewModel: BookViewModel
    var bookName: String
    var authorName: String
    var quoteContent: String
    var highlightTagName: String
    var highlightTagColor: String
    var isConnected: Bool
    var action: () -> Void
    
//    @Binding var connectedQuote: Int
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
//            isConnected.toggle()
            action()
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

                    Image(isConnected ? "curiCheckDone" : "curiCheckUndone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                }
                
                /// Quote
                Text("\"\(quoteContent)\"")
                    .curiTypo(.bkRegular16)
                    .foregroundStyle(curiPalette(.ink500))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                
                /// Highlight Tag
                HighlightTag(highlightName: highlightTagName, highlightColor: highlightTagColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(curiSpacing(.sp16))
            .background(
                RoundedRectangle(cornerRadius: curiRadius(.rd8))
                    .fill(curiPalette(.paper300))
            )
            .overlay(
                RoundedRectangle(cornerRadius: curiRadius(.rd8))
                    .strokeBorder(isConnected ? curiPalette(.ink500) :  curiPalette(.ink300), lineWidth: isConnected ? 1.6 : 0)
            )
        }

    }
}

#Preview {
    @Previewable @StateObject var bookViewModel = BookViewModel()
    @Previewable @State var connectedQuote: Int = 0
    VStack {
        QuoteCard(bookViewModel: bookViewModel, quoteBook: "Animal Farm", quoteAuthor: "George Orwell", quoteContent: "All that year the animals worked like slaves. But they were happy in their work; they grudged no effort or sacrifice, well aware that everything they did was for the benefit of themselves and those of their kind who would come after them, and not for a pack of idle, thieving human beings.", quoteHighlightName: "Discuss Later", quoteHighlightColor: "pink-200", action: {
            print("Navigation Card")
        })
        
        QuoteCardWithCheckbox(bookViewModel: bookViewModel, bookName: "Animal Farm", authorName: "George Orwell", quoteContent: "All that year the animals worked like slaves. But they were happy in their work; they grudged no effort or sacrifice, well aware that everything they did was for the benefit of themselves and those of their kind who would come after them, and not for a pack of idle, thieving human beings.", highlightTagName: "Discuss Later", highlightTagColor: "blue-200", isConnected: false, action: {
            print("Checkbox Card")
        })
    }
    .padding(16)
}
