//
//  QuoteView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 12/3/25.
//

import SwiftUI
import SwiftData

struct QuoteView: View {
    @ObservedObject var bookViewModel: BookViewModel

    @Environment(\.modelContext) var modelContext
//    @Query var quoteDatabase: [Quote]
    @Query(sort: \Quote.quoteAddedDate, order: .reverse) var quoteDatabase: [Quote]
    
    @State var viewAllNavigation: Bool = false
//    @State var isPresentedQuoteSheetView: Bool = false
    @State var newHighlightName: String = ""
    @State var isShowKeyboard: Bool = false
    @State var bookNavigated: Bool = false
    @State var itemSelected: Quote?
    
    @Binding var isPresentedRenameView: Bool
    
    var quoteOnPaper: Quote {
        if let first = quoteDatabase.first {
            return first
        } else {
            return Quote(bookID: UUID(), quoteBook: "", quoteAuthor: "", quoteContent: "", quoteHighlight: HighlightPencil(name: "", primaryTextColor: "", primaryBackgroundColor: "b", secondaryTextColor: "", secondaryBackgroundColor: "", highlightedTextColor: "", defaultHighlightedBackgroundColor: "", selectedHighlightedBackgroundColor: ""))
        }
    }
    
    var emptyHeadline: String = "No quotes yet, but that’s okay,"
    var emptyParagraph: String = "Start with a book, and mark your way!"
    
    var body: some View {
        if quoteDatabase.isEmpty {
            EmptyStateDescription(image: "curiLogo", headline: emptyHeadline, paragraph: emptyParagraph)
        } else {
            VStack (spacing: 0) {
                VStack (spacing: 0) {
                    if !isShowKeyboard {
                        QuotePaperGroup(highlight: quoteOnPaper.quoteHighlight, quote: quoteOnPaper, quoteContent: quoteOnPaper.quoteContent, quoteAuthor: quoteOnPaper.quoteAuthor, quoteBook: quoteOnPaper.quoteBook, paperAction: {
                            bookViewModel.quoteNoteSheetViewIsPresented.toggle()
                            itemSelected = quoteOnPaper
                        }, highlightAction: {
                            isPresentedRenameView.toggle()
                        })
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
            .sheet(isPresented: $bookViewModel.quoteNoteSheetViewIsPresented) {
                QuoteNoteSheetView(bookViewModel: bookViewModel, bookNavigated: $bookNavigated, quote: quoteOnPaper)
            }
            .navigationDestination(isPresented: $viewAllNavigation) {
                AllQuotesView(bookViewModel: bookViewModel)
            }
            .navigationDestination(isPresented: $bookNavigated) {
                if let book = bookViewModel.bookDatabase.first(where: { $0.title == itemSelected?.quoteBook }) {
                    BookView(
                        bookViewModel: bookViewModel,
                        bookLinesOriginal: book.lines,
                        bookID: book.id,
                        bookTitle: book.title,
                        bookAuthor: book.author
                    )
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

extension QuoteView {
    // MARK: - Keyboard Handling
    private func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil, queue: .main) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                let keyboardHeight = keyboardFrame.height
                self.isShowKeyboard = true
            }
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                               object: nil, queue: .main) { _ in
            withTransaction(Transaction(animation: .easeInOut(duration: 0.3))) {
                self.isShowKeyboard = false
            }
        }
    }

    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

#Preview {
    @Previewable @StateObject var bookViewModel = BookViewModel()
    QuoteView(bookViewModel: bookViewModel, isPresentedRenameView: .constant(false))
}
