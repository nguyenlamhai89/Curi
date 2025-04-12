//
//  QuoteNoteView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 3/3/25.
//

import SwiftUI
import SwiftData

struct QuoteNoteSheetView: View {
    @Bindable var bookViewModel: BookViewModel
    
    @Environment(\.modelContext) private var modelContext
    @Query var quoteDatabase: [Quote]
    
    @Environment(\.presentationMode) var presentationMode
    @State var shareThoughts: String = ""
    @State var connectQuoteNavigate: Bool = false
    @State var deleteAlertIsPresented: Bool = false
    
    let quote: Quote
    @State var isShowKeyboard: Bool = false
    
    init(bookViewModel: BookViewModel, quote: Quote) {
        self.bookViewModel = bookViewModel
        self.quote = quote
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack (spacing: curiSpacing(.sp20)){
                    VStack (spacing: curiSpacing(.sp8)) {
                        HighlightTag(content: "Discuss Later")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(quote.quoteContent)")
                            .curiTypo(.bkRegular16)
                            .foregroundStyle(curiPalette(.ink500))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                        HStack (spacing: curiSpacing(.sp8)) {
                            TextButtonFilledIcon(content: "Go to Book", icon: "curiBook", action: {
                                print("Go to Book")
                            })
                            
                            TextButtonFilledNumber(content: "Connect", icon: "curiConnect", connectedNumber: quote.connectedQuotes?.count ?? 0, action: {
                                connectQuoteNavigate.toggle()
                            })
                            .navigationDestination(isPresented: $connectQuoteNavigate) {
                                QuoteConnectView(quote: quote)
                            }
                            
                        }
                    }
                    TakeNoteField(shareThoughts: $shareThoughts, book: quote.quoteBook, author: quote.quoteAuthor)
                }
                .navigationTitle("Quote")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Done")
                                .fontWeight(.semibold)
                                .foregroundStyle(curiPalette(.ink500))
                        }
                    }
                }
                if !isShowKeyboard {
                    TextButtonPlain(content: "Delete Quote and Note", action: {
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
                if let quoteIsPresented = quoteDatabase.first(where: { $0.quoteContent == quote.quoteContent}) {
                    modelContext.delete(quoteIsPresented)
                    presentationMode.wrappedValue.dismiss()
                    print("Deleted!")
                }
            }))
        }
        .onChange(of: quoteDatabase) {
            print("✅ [\(quoteDatabase.count)] Quote Database: \(quoteDatabase)")
        }
        .onAppear() {
            print("🔖 Quote - \(quote.quoteContent)")
            print("🔖 Author - \(quote.quoteAuthor)")
            print("🔖 Book - \(quote.quoteBook)")
            print("Raw Data: \(quote)")
            setupKeyboardObserver()
        }
        .onDisappear {
            removeKeyboardObserver()
        }
    }
    
}

//#Preview {
//    @Previewable @Bindable var bookViewModel = BookViewModel()
//    QuoteNoteSheetView(bookViewModel: bookViewModel, quote: Quo)
//}

extension QuoteNoteSheetView {
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
