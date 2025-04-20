//
//  BookView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 5/3/25.
//

import SwiftUI
import SwiftData

struct BookView: View {
    @Bindable var bookViewModel: BookViewModel
    
    @Environment(\.modelContext) private var modelContext
    @Query var quoteDatabase: [Quote]
    @Query var pencilDatabase: [HighlightPencil]
    
    @State var isPresentedRenameView: Bool = false
    @State var newHighlightName: String = ""

    @State var bookLinesOriginal: [String]
    @State var isShowKeyboard: Bool = false
    @FocusState private var autoFocusRename: Bool
    
    
    var bookID: UUID
    var bookTitle: String
    var bookAuthor: String
    
    var body: some View {
        ZStack {
            // Book content
            VStack (spacing: curiSpacing(.sp20)) {
                ScrollView(content: {
                    VStack (spacing: 20) {
                        Text(bookTitle)
                            .curiTypo(.bkBold16)
                            .multilineTextAlignment(.center)
                        LinesView(bookViewModel: bookViewModel, bookID: bookID, bookTitle: bookTitle, bookAuthor: bookAuthor, bookHighlightName: bookViewModel.selectedPen?.name ?? "", bookLinesOriginal: bookLinesOriginal)
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
                    bookViewModel.pageIsSelected.toggle()
                    bookViewModel.selectedLine = nil
                }
            }
            
            VStack {
                // Navigation
                TopNavigationBook(pageIsSelected: bookViewModel.pageIsSelected)
//                    .background(Color.blue)
                
                Spacer()
                
                // Highlight
                if !isShowKeyboard {
                    HighlightDial(bookViewModel: bookViewModel, thoughtSheetIsPresented: $bookViewModel.quoteNoteSheetViewIsPresented, deleteAlertIsPresented: $bookViewModel.deleteAlertIsPresented) {
                        isPresentedRenameView.toggle()
                    }
                    .bottomNavigationSpacing
                }
            }
            
        }
        .background(curiPalette(.paper500))
//        .background(Color.cyan) // Check section
        .navigationBarHidden(true)
        .overlay(content: {
            if isPresentedRenameView {
                if let selectedPen = bookViewModel.selectedPen {
                    let bindingToName = Binding(
                        get: { selectedPen.name },
                        set: { newValue in
                            selectedPen.name = newValue
                            try? modelContext.save()
                        }
                    )

                    RenameHighlightView(
                        highlightName: bindingToName, backgroundColor: Color(selectedPen.primaryBackgroundColor)
                    ) {
                        isPresentedRenameView.toggle()
                    }
                }
            }
        })
        .alert(isPresented: $bookViewModel.deleteAlertIsPresented) {
            Alert(
                title: Text("Delete Quote and Note?"),
                message: Text("Are you sure you want to delete the quote and the note?"),
                primaryButton: .cancel(),
                secondaryButton: .destructive(Text("Delete"), action: {
                    modelContext.delete(bookViewModel.selectedLine!)
                })
            )
        }
        .sheet(isPresented: $bookViewModel.quoteNoteSheetViewIsPresented) {
            if let selectedQuote = bookViewModel.selectedLine {
                QuoteNoteSheetView(bookViewModel: bookViewModel, quote: selectedQuote)
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

extension BookView {
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
