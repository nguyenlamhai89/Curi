//
//  QuoteNoteView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 3/3/25.
//

import SwiftUI
import SwiftData
import WidgetKit

struct QuoteNoteSheetView: View {
    /// SwiftData
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Quote.quoteAddedDate, order: .reverse) var quoteDatabase: [Quote]
    
    /// Local View
    @ObservedObject var bookViewModel: BookViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var connectQuoteNavigate: Bool = false
    @State var deleteAlertIsPresented: Bool = false
    @State var isShowKeyboard: Bool = false
    @Binding var bookNavigated: Bool
    @Bindable var quote: Quote
    var shareThoughtsBinding: Binding<String> {
        Binding(
            get: { quote.quoteNote.noteContent },
            set: { quote.quoteNote.noteContent = $0 }
        )
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack (spacing: curiSpacing(.sp20)){
                    VStack (spacing: curiSpacing(.sp8)) {
                        HighlightTag(highlightName: quote.quoteHighlight?.name ?? "", highlightColor: quote.quoteHighlight?.primaryBackgroundColor ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\"\(quote.quoteContent)\"")
                            .curiTypo(.bkRegular16)
                            .foregroundStyle(curiPalette(.ink500))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                        HStack (spacing: curiSpacing(.sp8)) {
                            if !bookViewModel.accessSheetFromBookView {
                                TextButtonFilledIcon(bookViewModel: bookViewModel, content: "Go to Book", icon: "curiBook", action: {
                                    presentationMode.wrappedValue.dismiss()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                        bookNavigated.toggle()
                                    }
                                })
                            } else {
                                EmptyView()
                            }
                            
                            TextButtonFilledNumber(bookViewModel: bookViewModel, content: "Connect", icon: "curiConnect", connectedNumber: quote.connectedQuotes?.count ?? 0, action: {
                                connectQuoteNavigate.toggle()
                            })
                            .navigationDestination(isPresented: $connectQuoteNavigate) {
                                QuoteConnectView(bookViewModel: bookViewModel, quote: quote)
                            }
                            
                        }
                    }
                    
                    TakeNoteField(bookViewModel: bookViewModel, shareThoughts: shareThoughtsBinding, book: quote.quoteBook, author: quote.quoteAuthor)
                }
                .navigationTitle("Quote")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        IconButton(bookViewModel: bookViewModel, iconName: "curiDelete", hasNote: false) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                
                if !isShowKeyboard {
                    TextButtonPlain(bookViewModel: bookViewModel, content: "Delete Quote and Note", action: {
                        deleteAlertIsPresented.toggle()
                        print("Delete")
                    })
                    .bottomNavigationSpacing
                }
                
            }
            .padding(.horizontal, curiSpacing(.sp16))
            .background(curiPalette(.paper500))
            .navigationTitle("Quote")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        .presentationDragIndicator(.hidden)
        .interactiveDismissDisabled(true)
        .alert(isPresented: $deleteAlertIsPresented) {
            Alert(title: Text("Delete Quote and Note?"),
                  message: Text("Are you sure you want to delete the quote and the note?"),
                  primaryButton: .cancel(),
                  secondaryButton: .destructive(Text("Delete"), action: {
                // Delete Quote
                bookViewModel.deleteQuoteInSheet(quoteDatabase: quoteDatabase, quote: quote, modelContext: modelContext)
                presentationMode.wrappedValue.dismiss()
            }))
        }
        .onChange(of: quoteDatabase) {
            bookViewModel.updateQOTD(quoteDatabase: quoteDatabase)
        }
        .onChange(of: bookViewModel.quoteChangedTrigger) {
            bookViewModel.updateQOTD(quoteDatabase: quoteDatabase)
        }
        .onAppear() {
            setupKeyboardObserver()
            
            print("🔖 Quote - \(quote.quoteContent)")
            print("🔖 Author - \(quote.quoteAuthor)")
            print("🔖 Book - \(quote.quoteBook)")
            print("Raw Data: \(quote)")
        }
        .onDisappear {
            removeKeyboardObserver()
        }
    }
    
}

extension QuoteNoteSheetView {
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
    
    QuoteNoteSheetView(bookViewModel: bookViewModel, bookNavigated: .constant(false), quote: Quote(quoteID: UUID(), quoteLineNum: 0, quoteAddedDate: Date(), quoteBook: "Test Book", quoteAuthor: "Test Author", quoteContent: "Test Quote Content Bla Blo Bla Blo", quoteHighlight: HighlightPencil(name: "Test Highlight Name", primaryTextColor: "paper-500", primaryBackgroundColor: "blue-300", isPresentedRenameView: false, secondaryTextColor: "blue-500", secondaryBackgroundColor: "blue-100", highlightedTextColor: "blue-500", defaultHighlightedBackgroundColor: "blue-100", selectedHighlightedBackgroundColor: "blue-200"), isConnected: false, quoteNote: Note(noteContent: "")))
}
