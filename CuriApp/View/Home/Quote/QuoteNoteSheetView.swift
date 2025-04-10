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
    
//    @State var highlight: AttributedString
//    let quoteChecking: Quote
    let quote: Quote
//    let quote: String
//    let author: String
//    let book: String
    
    init(bookViewModel: BookViewModel, quote: Quote) {
        self.bookViewModel = bookViewModel
        self.quote = quote
    }
//    init(bookViewModel: BookViewModel, quote: String, author: String, book: String) {
//        self.bookViewModel = bookViewModel
//        self.quote = quote
//        self.author = author
//        self.book = book
//    }
//    init(bookViewModel: BookViewModel, quoteChecking: Quote, quote: String, author: String, book: String) {
//        self.bookViewModel = bookViewModel
//        self.quoteChecking = quoteChecking
//        self.quote = quote
//        self.author = author
//        self.book = book
//    }
    
//    var deletePositionIndex: Int
    
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
                            
                            TextButtonFilledIcon(content: "Connect", icon: "curiConnect", action: {
                                connectQuoteNavigate.toggle()
                                if connectQuoteNavigate {
                                    print("Connect")
                                } else {
                                    print("Error")
                                }
                            })
                            .navigationDestination(isPresented: $connectQuoteNavigate) {
                                QuoteConnectView()
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
                
                TextButtonPlain(content: "Delete Quote and Note", action: {
                    deleteAlertIsPresented.toggle()
                    print("Delete")
                })
                .bottomNavigationSpacing
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
//                bookViewModel.highlightDatabase.remove(at: deletePositionIndex)
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
        }
    }
    
}

//#Preview {
//    @Previewable @Bindable var bookViewModel = BookViewModel()
//    QuoteNoteSheetView(bookViewModel: bookViewModel)
//}
