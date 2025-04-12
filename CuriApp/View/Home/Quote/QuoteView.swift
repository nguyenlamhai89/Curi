//
//  QuoteView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 12/3/25.
//

import SwiftUI
import SwiftData

struct QuoteView: View {
    // Binding from HomeView
    @Bindable var bookViewModel: BookViewModel
    @Query var quoteDatabase: [Quote]
    
    @Binding var nameHighlightPrimary: String
    @Binding var nameHighlightSecondary: String
    var placeholderHighlightName: String
    @Binding var renameViewPrimary: Bool
    @Binding var renameViewSecondary: Bool
    
    @Binding var quoteCardIsPresented: Bool
    @Binding var viewAllNavigation: Bool
    
    @State var isShowKeyboard: Bool = false
    
    var quote: Quote {
        if let first = quoteDatabase.first {
            return first
        } else {
            return Quote(bookID: UUID(), quoteBook: "", quoteAuthor: "", quoteContent: "", quoteHighlightName: "")
        }
    }
    
    var emptyHeadline: String = "No quotes yet, but that’s okay,"
    var emptyParagraph: String = "Start with a book, and mark your way!"
    
    var body: some View {
        if quoteDatabase.isEmpty {
            EmptyStateDescription(headline: emptyHeadline, paragraph: emptyParagraph)
        } else {
            VStack (spacing: 0) {
                VStack (spacing: 0) {
                    if !isShowKeyboard {
                        
                        QuotePaperGroup(quote: quote, quoteContent: quote.quoteContent, quoteAuthor: quote.quoteAuthor, quoteBook: quote.quoteBook, paperAction: {
                            quoteCardIsPresented.toggle()
                        }, highlightContent: nameHighlightPrimary, highlightColor: curiPalette(.blue300)) {
                            renameViewPrimary.toggle()
                        }
                        .padding(curiSpacing(.sp16))
                        
                        TextButtonPlain(content: "Show All (\(quoteDatabase.count))") {
                            viewAllNavigation.toggle()
                            print("All")
                        }
                        .bottomNavigationSpacing
                        
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 74)
            }
            .sheet(isPresented: $quoteCardIsPresented) {
                QuoteNoteSheetView(bookViewModel: bookViewModel, quote: quote, nameHighlightPrimary: nameHighlightPrimary, nameHighlightSecondary: nameHighlightSecondary)
            }
            .navigationDestination(isPresented: $viewAllNavigation) {
                AllQuotesView(bookViewModel: bookViewModel, nameHighlightPrimary: nameHighlightPrimary, nameHighlightSecondary: nameHighlightSecondary)
            }
            .overlay {
                if renameViewPrimary {
                    RenameHighlightView(backgroundColor: curiPalette(.blue500),
                                        placeholderHighlightName: placeholderHighlightName,
                                        highlightName: $nameHighlightPrimary,
                                        viewIsPresented: $renameViewPrimary)
                }
            }
            .onAppear {
                setupKeyboardObserver()
            }
            .onDisappear {
                removeKeyboardObserver()
            }
        }
        
    }
}

#Preview {
    @Previewable @State var bookViewModel = BookViewModel()
    @Previewable @State var nameHighlightPrimary: String = "Discuss Later"
    @Previewable @State var nameHighlightSecondary: String = "Good Point"
    @Previewable @State var renameViewPrimary: Bool = false
    @Previewable @State var renameViewSecondary: Bool = false
    @Previewable @State var quoteCardIsPresented: Bool = false
    @Previewable @State var viewAllNavigation: Bool = false
    
    QuoteView(bookViewModel: bookViewModel, nameHighlightPrimary: $nameHighlightPrimary, nameHighlightSecondary: $nameHighlightSecondary, placeholderHighlightName: "Your highlight name", renameViewPrimary: $renameViewPrimary, renameViewSecondary: $renameViewSecondary, quoteCardIsPresented: $quoteCardIsPresented, viewAllNavigation: $viewAllNavigation)
}

extension QuoteView {
    private func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                let keyboardHeight = keyboardFrame.height
                self.isShowKeyboard = true
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            self.isShowKeyboard = false
        }
    }
    
    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
