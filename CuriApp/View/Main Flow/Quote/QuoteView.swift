//
//  QuoteView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 12/3/25.
//

import SwiftUI
import SwiftData
import Mixpanel

struct QuoteView: View {
    /// SwiftData
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Quote.quoteAddedDate, order: .reverse) var quoteDatabase: [Quote]
    @Query var pencilDatabase: [HighlightPencil]
    @Query var userSettings: [User]
    
    /// Local View
    @ObservedObject var bookViewModel: BookViewModel
    @State var viewAllNavigation: Bool = false
    @State var newHighlightName: String = ""
    @State var isShowKeyboard: Bool = false
    @State var bookNavigated: Bool = false
    @State var itemSelected: Quote?
    @Binding var isPresentedRenameView: Bool
    
    var quoteOnPaper: Quote {
        if let first = quoteDatabase.first {
            return first
        } else {
            return Quote(quoteID: UUID(), quoteLineNum: 0, quoteAddedDate: Date(), quoteBook: "", quoteAuthor: "", quoteContent: "", quoteHighlight: HighlightPencil(name: "", primaryTextColor: "", primaryBackgroundColor: "", secondaryTextColor: "", secondaryBackgroundColor: "", highlightedTextColor: "", defaultHighlightedBackgroundColor: "", selectedHighlightedBackgroundColor: ""), isConnected: false, quoteNote: Note(noteContent: ""))
        }
    }
    
    /// Empty State
    var emptyQuoteImage: String = "curiQuoteEmpty"
    var emptyQuoteHeadline: String = "No quotes yet, but that’s okay"
    var emptyQuoteParagraph: String = "Start with a book, and mark your way!"
    
    var body: some View {
        if quoteDatabase.isEmpty {
            EmptyStateDescription(image: emptyQuoteImage, headline: emptyQuoteHeadline, paragraph: emptyQuoteParagraph)
        } else {
            VStack (spacing: 0) {
                VStack (spacing: 0) {
                    if !isShowKeyboard {
                        QuotePaperGroup(bookViewModel: bookViewModel, highlight: quoteOnPaper.quoteHighlight ?? HighlightPencil(name: "", primaryTextColor: "", primaryBackgroundColor: "", secondaryTextColor: "", secondaryBackgroundColor: "", highlightedTextColor: "", defaultHighlightedBackgroundColor: "", selectedHighlightedBackgroundColor: ""), quote: quoteOnPaper, quoteContent: quoteOnPaper.quoteContent, quoteAuthor: quoteOnPaper.quoteAuthor, quoteBook: quoteOnPaper.quoteBook, paperAction: {
                            bookViewModel.quoteNoteSheetViewIsPresented.toggle()
                            itemSelected = quoteOnPaper
                        }, highlightAction: {
                            isPresentedRenameView.toggle()
                        })
                        .padding(curiSpacing(.sp16))
                                            
                        TextButtonPlain(bookViewModel: bookViewModel, content: "Show All (\(quoteDatabase.count))") {
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
                    .onAppear {
                        Mixpanel.mainInstance().track(event: "goToAllQuotes_FromQuoteView")
                    }
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
                Mixpanel.mainInstance().track(event: "view_Quote")
                setupKeyboardObserver()
            }
            .onDisappear {
                removeKeyboardObserver()
            }
            .onChange(of: quoteDatabase) {
                if let thisUser = userSettings.first {
                    thisUser.quoteDatabase = quoteDatabase
                    thisUser.pencilDatabase = pencilDatabase
                    try? modelContext.save()
                    print("Quote Database: \(String(describing: thisUser.quoteDatabase))")
                    print("Pencil Database: \(String(describing: thisUser.pencilDatabase))")
                } else {
                    print("-- Nil!")
                }
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
