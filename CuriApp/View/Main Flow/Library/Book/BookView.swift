//
//  BookView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 5/3/25.
//

import SwiftUI
import SwiftData
import WidgetKit

struct BookView: View {
    @ObservedObject var bookViewModel: BookViewModel
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @Query(sort: \Quote.quoteAddedDate, order: .reverse) var quoteDatabase: [Quote]
    @Query var pencilDatabase: [HighlightPencil]
    @Query var userSettings: [UserSettingsStats]
    
    @State var isPresentedRenameView: Bool = false
    @State var newHighlightName: String = ""

    @State var bookLinesOriginal: [String]
    @State var isShowKeyboard: Bool = false
    @State var highlightNewFeature: Bool = false
    
    
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
                        LinesView(bookViewModel: bookViewModel, bookTitle: bookTitle, bookAuthor: bookAuthor, bookHighlightName: bookViewModel.selectedPen?.name ?? "", bookLinesOriginal: bookLinesOriginal)
                            .curiTypo(.bkRegular16)
                    }
                    .padding(.top, 120)
                    .padding(.bottom, 160)
                })
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
                TopNavigationBook(bookViewModel: bookViewModel, pageIsSelected: bookViewModel.pageIsSelected, highlightNewFeature: $highlightNewFeature)
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
                        bookViewModel.quoteChangedTrigger = UUID()
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
                QuoteNoteSheetView(bookViewModel: bookViewModel, bookNavigated: .constant(false), quote: selectedQuote)
            }
        }
        .sheet(isPresented: $highlightNewFeature, content: {
            NewFeatureIntroducingView(
                bookViewModel: bookViewModel,
                featureBannerGIF: "curiHighlightIntroducingGIF.gif",
                featureIconLeft: "curiHighlightLeft",
                featureIconRight: "curiHighlightRight",
                featureName: "Curi's Highlight",
                featureHeadline: "Mark what matters",
                featureDescription: "A sentence can be more than words — it can be a feeling, a memory, or a moment of clarity.",
                featureCTA: "Got it",
                stepsWidget: [("curiHighlightStep1", "Swipe the highlight dial below to pick a color that fits your theme."), ("curiHighlightStep2", "Tap and hold a sentence to leave your mark."), ("curiHighlightStep3", "Tap again and leave your thoughts - or swipe to change the color")]
            )
        })
        .onChange(of: quoteDatabase) {
            print("✅ [\(quoteDatabase.count)] Quotes: \(quoteDatabase)")
            bookViewModel.updateQuoteOnWidget(quoteDatabase: quoteDatabase)
//            WidgetDataManager.access.updateQuoteOnWidget(quoteDatabase: quoteDatabase)
        }
        .onChange(of: bookViewModel.quoteChangedTrigger) {
            print("✅ [\(quoteDatabase.count)] Quotes: \(quoteDatabase)")
            bookViewModel.updateQuoteOnWidget(quoteDatabase: quoteDatabase)
//            WidgetDataManager.access.updateQuoteOnWidget(quoteDatabase: quoteDatabase)
        }
        .onAppear {
            if userSettings.count != 1 {
                print("❌ Not found US")
            } else {
                print("✅ User Settings: \(userSettings)")
            }
            bookViewModel.accessSheetFromBookView = true
            setupKeyboardObserver()
            if !bookViewModel.firstTimeReading {
                return
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    highlightNewFeature = true
                    bookViewModel.firstTimeReading = false
                }
            }
        }
        .onDisappear {
            bookViewModel.accessSheetFromBookView = false
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
