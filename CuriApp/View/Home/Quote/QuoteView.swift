//
//  QuoteView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 12/3/25.
//

import SwiftUI
import SwiftData

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
    @Bindable var bookViewModel: BookViewModel
    @Query var highlightDatabase: [Highlight]
    
    @Binding var nameHighlightPrimary: String
    @Binding var nameHighlightSecondary: String
    var placeholderHighlightName: String
    @Binding var renameViewPrimary: Bool
    @Binding var renameViewSecondary: Bool
    
    @Binding var quoteCardisPresented: Bool
    @Binding var viewAllNavigation: Bool
    
    var quoteInPaper: String = "“It is only with the heart that one can see rightly; what is essential is invisible to the eye.”"
    var authorInPaper: String = "John Doe"
    var bookInPaper: String = "Sample"
    
    var body: some View {
        //        VStack (spacing: curiSpacing(.sp16)) {
        //            QuoteNode(quoteTitle: "“the way to prevent further crisis is better technology, more laws, and bigger bureaucracy.”")
        //            HighlightNode(highlightName: nameHighlightPrimary, highlightColor: curiPalette(.blue300)) {
        //                renameHighlightPrimaryView.toggle()
        //            }
        //            QuoteNode(quoteTitle: "“It is only with the heart that one can see rightly; what is essential is invisible to the eye.”")
        //        }
        VStack (spacing: 0) {
            // Main Section
            VStack (spacing: 0) {
                QuotePapers(quoteInPaper: quoteInPaper, authorInPaper: authorInPaper, bookInPaper: bookInPaper, buttonName: "Details") {
                    quoteCardisPresented.toggle()
                    print("Details")
                }
                .padding(.horizontal, curiSpacing(.sp16))
                TextButtonPlain(content: "Show All (\(highlightDatabase.count))") {
                    viewAllNavigation.toggle()
                    print("All")
                }
                .bottomNavigationSpacing
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 74)
//            .background(Color.blue) // Check section
            
        }
        .sheet(isPresented: $quoteCardisPresented) {
            QuoteNoteSheetView(bookViewModel: bookViewModel, quote: quoteInPaper, author: authorInPaper, book: bookInPaper)
        }
        .navigationDestination(isPresented: $viewAllNavigation) {
            AllQuotesView(quoteCardisPresented: $quoteCardisPresented, bookViewModel: bookViewModel)
        }
    }
}

#Preview {
//    QuoteView(nameHighlightPrimary: .constant("Discuss Later"), nameHighlightSecondary: .constant("Good Point"), placeholderHighlightName: "Name your highlight", renameViewPrimary: .constant(false), renameViewSecondary: .constant(false))
}
