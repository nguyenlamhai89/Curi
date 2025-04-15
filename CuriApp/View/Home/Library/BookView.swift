//
//  BookView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 5/3/25.
//

import SwiftUI
import SwiftData

struct BookView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var quoteDatabase: [Quote]
    
//    @State var selectedPen: HighlightPen
    
//     Local
    @State var quoteSelected: Bool = true
    @State var thoughtSheetIsPresented: Bool = false
    @State var deleteAlertIsPresented: Bool = false
    @FocusState private var autoFocusRename: Bool
    
    @Bindable var bookViewModel: BookViewModel
    
    var bookID: UUID
    var bookTitle: String
    var bookAuthor: String
    @State var bookLinesOriginal: [String]
//    @State var bookLinesHighlighted: [String] = []
    
    // Binding from HomeView
//    @Binding var nameHighlightPrimary: String
//    @Binding var nameHighlightSecondary: String
    var placeholderHighlightName: String
//    @Binding var renameHighlightPrimaryView: Bool
//    @Binding var renameHighlightSecondaryView: Bool
//    var bookNameAtNavigationForEach: String
    
    @State var isShowKeyboard: Bool = false
    
    var body: some View {
        ZStack {
            // Book content
            VStack (spacing: curiSpacing(.sp20)) {
                ScrollView(content: {
                    VStack (spacing: 20) {
                        Text(bookTitle)
                            .curiTypo(.bkBold16)
                            .multilineTextAlignment(.center)
                        LinesView(bookViewModel: bookViewModel, bookID: bookID, bookTitle: bookTitle, bookAuthor: bookAuthor, bookHighlightName: bookViewModel.highlightPenStorage[0].defaultName, bookLinesOriginal: bookLinesOriginal)
                    }
                    .padding(.top, 120)
                    .padding(.bottom, 160)
                })
                .curiTypo(.bkRegular16)
                .padding(.horizontal, 32)
                .scrollIndicators(.hidden)
//                .background(Color.green) // Check section
                
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .ignoresSafeArea()
            .onTapGesture {
                withAnimation {
                    quoteSelected.toggle()
                }
            }
            
            VStack {
                // Navigation
                TopNavigationBook(quoteIsSelected: quoteSelected)
//                    .background(Color.blue)
                
                Spacer()
                
                // Highlight
                HighlightDial(
                    bookViewModel: bookViewModel,
                    quoteIsSelected: quoteSelected,
                    thoughtSheetIsPresented: $thoughtSheetIsPresented,
                    deleteAlertIsPresented: $deleteAlertIsPresented
                )
                .bottomNavigationSpacing
            }
            
        }
        .background(curiPalette(.paper500))
//        .background(Color.cyan) // Check section
        .navigationBarHidden(true)
        /// Change Name View
//        .overlay(content: {
//            if renameHighlightPrimaryView {
//                RenameHighlightView(backgroundColor: curiPalette(.blue500), placeholderHighlightName: placeholderHighlightName, highlightName: $nameHighlightPrimary, viewIsPresented: $renameHighlightPrimaryView, autoFocus: _autoFocusRename)
//            }
//            
//            if renameHighlightSecondaryView {
//                RenameHighlightView(backgroundColor: curiPalette(.pink500), placeholderHighlightName: placeholderHighlightName, highlightName: $nameHighlightSecondary, viewIsPresented: $renameHighlightSecondaryView, autoFocus: _autoFocusRename)
//            }
//        })
//        .overlay(content: {
//            if ((bookViewModel.selectedPen?.isPresentedRenameView) != nil) {
//                RenameHighlightView(backgroundColor: bookViewModel.selectedPen.selectedBackgroundColor, placeholderHighlightName: placeholderHighlightName, highlightName: $bookViewModel.selectedPen.defaultName, viewIsPresented: $bookViewModel.selectedPen.isPresentedRenameView)
//            }
//        })
//        .overlay {
//            if let selectedPen = bookViewModel.selectedPen,
//               selectedPen.isPresentedRenameView {
//                RenameHighlightView(
//                    backgroundColor: selectedPen.selectedBackgroundColor,
//                    placeholderHighlightName: placeholderHighlightName,
//                    highlightName: $selectedPen.defaultName,
//                    viewIsPresented: $selectedPen.isPresentedRenameView
//                )
//            }
//        }
        .alert(isPresented: $deleteAlertIsPresented) {
            Alert(title: Text("Delete Quote and Note?"),
                  message: Text("Are you sure you want to delete the quote and the note?"),
                  primaryButton: .cancel(),
                  secondaryButton: .destructive(Text("Delete"), action: {
                print("Deleted!")
            }))
        }
//        .onAppear {
//            setupKeyboardObserver()
//        }
//        .onDisappear {
//            removeKeyboardObserver()
//        }

    }
}

//#Preview {
//    @Previewable @Bindable var bookViewModel = BookViewModel()
//    let bookIDFake = UUID()
////    BookView(bookViewModel: bookViewModel, bookID: bookIDFake, bookTitle: "Harry Pọt Tơ", bookAuthor: "William Shakespeare", bookLinesOriginal: [
////        "FROM off a hill whose concave womb reworded",
////        "A plaintful story from a sistering vale,",
////        "My spirits to attend this double voice accorded,",
////        "And down I laid to list the sad-tuned tale;"
////    ], nameHighlightPrimary: .constant("Discuss Later"), nameHighlightSecondary: .constant("Good Point"), placeholderHighlightName: "Your highlight name", renameHighlightPrimaryView: .constant(false), renameHighlightSecondaryView: .constant(false))
//    
//    BookView(selectedPen: HighlightPen(defaultName: "Discussssss", selectedTextColor: Color.red, selectedBackgroundColor: Color.red.opacity(0.2)), unselectedTextColor: Color.blue, unselectedBackgroundColor: Color.yellow);, bookViewModel: bookViewModel, bookID: bookIDFake, bookTitle: "Harry Pọt Tơ", bookAuthor: "William Shakespeare", bookLinesOriginal: ["FROM off a hill whose concave womb reworded", "A plaintful story from a sistering vale,", "My spirits to attend this double voice accorded,", "And down I laid to list the sad-tuned tale;"], nameHighlightPrimary: .constant("Discuss Later"), nameHighlightSecondary: .constant("Goodđ"), placeholderHighlightName: "Your Highlight Name", renameHighlightPrimaryView: .constant(false), renameHighlightSecondaryView: .constant(false))
//}

//struct LinesView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query var quoteDatabase: [Quote]
//    
//    var bookID: UUID
//    var bookTitle: String
//    var bookAuthor: String
//    var bookHighlightName: String
//    var bookLinesOriginal: [String]
//    
//    var selectedHighlightPen: HighlightPen?
//    
//    var body: some View {
//        VStack (spacing: 8) {
//            ForEach(bookLinesOriginal, id: \.self) { line in
//                Text(line)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .onLongPressGesture {
//                        print("\(line)")
//                        let quote = Quote(bookID: bookID, quoteBook: bookTitle, quoteAuthor: bookAuthor, quoteContent: line, quoteHighlightName: bookHighlightName)
//                        
//                        print("- BookID: \(quote.bookID)")
//                        print("- QuoteID: \(quote.quoteID)")
//                        print("- Title: \(quote.quoteBook)")
//                        print("- Author: \(quote.quoteAuthor)")
//                        print("📝 -------- \(quote.quoteContent) - \(quote.quoteHighlightName)")
//
//                        checkQuoteDatabase(checkingQuote: quote, currentLine: line)
//                        
//                    }
//                    .foregroundStyle(quoteDatabase.contains(where: { $0.quoteContent == line }) ? curiPalette(.blue500) : curiPalette(.ink500))
//                    .background(quoteDatabase.contains(where: { $0.quoteContent == line }) ? curiPalette(.blue100) : Color.clear)
////                    .foregroundStyle(quoteDatabase.contains(where: { $0.quoteContent == line }) ?
////                                     (selectedHighlightPen?.highlightedTextColor ?? curiPalette(.blue500)) :
////                                     curiPalette(.ink500))
////
////                    .background(quoteDatabase.contains(where: { $0.quoteContent == line }) ?
////                                (selectedHighlightPen?.unselectedHighlightedBackgroundColor ?? curiPalette(.blue100)) :
////                                Color.clear)
//            }
//            .onChange(of: quoteDatabase) {
//                print("✅ [\(quoteDatabase.count)] Quotes: \(quoteDatabase)")
//            }
//        }
//    }
//    
//    func checkQuoteDatabase(checkingQuote: Quote, currentLine: String) {
//        if let existingQuote = quoteDatabase.first(where: { $0.quoteContent == currentLine }) {
//            HapticsManager.access.play(haptics: .light)
//            SoundManager.access.play(sound: .highlightRemoved)
//            modelContext.delete(existingQuote)
//        } else {
//            HapticsManager.access.play(haptics: .light)
//            SoundManager.access.play(sound: .highlightAdded)
//            modelContext.insert(checkingQuote)
//        }
//    }
//}

//extension BookView {
//    private func setupKeyboardObserver() {
//        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
//            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
//                let keyboardHeight = keyboardFrame.height
//                self.isShowKeyboard = true
//            }
//        }
//        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
//            self.isShowKeyboard = false
//        }
//    }
//    
//    private func removeKeyboardObserver() {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//}
