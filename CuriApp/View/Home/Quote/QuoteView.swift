//
//  QuoteView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 12/3/25.
//

import SwiftUI

//struct HighlightNode: View {
//    var highlightName: String
//    var highlightColor: Color
//    var action: () -> Void
//    
//    var body: some View {
//        VStack (spacing: curiSpacing(.sp4)) {
//            HighlightButton(content: highlightName, color: highlightColor) {
//                action()
//                print("Discuss Later Pressed")
//            }
//            Circle()
//                .fill(highlightColor)
//                .frame(width: 24, height: 24)
//        }
//    }
//}
//
//struct QuoteNode: View {
//    var quoteTitle: String
//    var body: some View {
//        VStack(spacing: curiSpacing(.sp4)) {
//            Text(quoteTitle)
//                .curiTypo(.bkRegular12)
//                .foregroundStyle(curiPalette(.ink500))
//                .lineLimit(2)
//                .multilineTextAlignment(.center)
//            Circle()
//                .fill(curiPalette(.ink100))
//                .frame(width: 24, height: 24)
//        }
//        .frame(maxWidth: 160)
//    }
//}

struct QuoteView: View {
    // Binding from HomeView
    @Binding var nameHighlightPrimary: String
    @Binding var nameHighlightSecondary: String
    var placeholderHighlightName: String
    @Binding var renameViewPrimary: Bool
    @Binding var renameViewSecondary: Bool
    
    var body: some View {
        //        VStack (spacing: curiSpacing(.sp16)) {
        //            QuoteNode(quoteTitle: "“the way to prevent further crisis is better technology, more laws, and bigger bureaucracy.”")
        //            HighlightNode(highlightName: nameHighlightPrimary, highlightColor: curiPalette(.blue300)) {
        //                renameHighlightPrimaryView.toggle()
        //            }
        //            QuoteNode(quoteTitle: "“It is only with the heart that one can see rightly; what is essential is invisible to the eye.”")
        //        }
        
        VStack {
            // Main Section
            VStack (spacing: curiSpacing(.sp32)) {
                QuotePapers(quoteInPaper: "Hi", authorInPaper: "Haha", bookInPaper: "Hehe", buttonName: "Details") {
                    print("Details")
                }
                TextButtonPlain(content: "View All") {
                    print("All")
                }
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.blue) // Check section
            
            Spacer()
            
            HighlightDial(quoteIsSelected: false, thoughtSheetIsPresented: .constant(false), deleteAlertIsPresented: .constant(false), renameViewPrimary: $renameViewPrimary, renameViewSecondary: $renameViewSecondary, highlightName1: nameHighlightPrimary, highlightName2: nameHighlightSecondary)
                .bottomNavigationSpacing
        }
        
    }
}

#Preview {
    QuoteView(nameHighlightPrimary: .constant("Discuss Later"), nameHighlightSecondary: .constant("Good Point"), placeholderHighlightName: "Name your highlight", renameViewPrimary: .constant(false), renameViewSecondary: .constant(false))
}
