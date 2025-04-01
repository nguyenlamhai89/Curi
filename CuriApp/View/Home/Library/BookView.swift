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
    @Query var highlightDatabase: [Highlight]
    
//     Local
    @State var quoteSelected: Bool = true
    @State var thoughtSheetIsPresented: Bool = false
    @State var deleteAlertIsPresented: Bool = false
    @FocusState private var autoFocusRename: Bool
    
    @Bindable var bookViewModel: BookViewModel
    
    var bookID: UUID
    var bookTitle: String
//    @State var bookLines: [AttributedString] = []
    @State var bookLinesOriginal: [String]
//    @State var bookLinesHighlighted: [String] = []
    
    // Binding from HomeView
    @Binding var nameHighlightPrimary: String
    @Binding var nameHighlightSecondary: String
    var placeholderHighlightName: String
    @Binding var renameHighlightPrimaryView: Bool
    @Binding var renameHighlightSecondaryView: Bool
//    var bookNameAtNavigationForEach: String
    
    var body: some View {
        ZStack {
            // Book content
            VStack (spacing: curiSpacing(.sp20)) {
                ScrollView(content: {
                    VStack (spacing: 20) {
                        Text(bookTitle)
                            .curiTypo(.bkBold16)
                            .multilineTextAlignment(.center)
                        LinesView(bookID: bookID, bookTitle: bookTitle, bookLinesOriginal: bookLinesOriginal)
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
                HighlightDial(quoteIsSelected: quoteSelected, thoughtSheetIsPresented: $thoughtSheetIsPresented, deleteAlertIsPresented: $deleteAlertIsPresented, renameHighlightViewIsPresented1: $renameHighlightPrimaryView, renameHighlightViewIsPresented2: $renameHighlightSecondaryView, highlightName1: nameHighlightPrimary, highlightName2: nameHighlightSecondary)
                    .bottomNavigationSpacing
            }
            
        }
        .background(curiPalette(.paper500))
//        .background(Color.cyan) // Check section
        .navigationBarHidden(true)
        /// Change Name View
        .overlay(content: {
            if renameHighlightPrimaryView {
                RenameHighlightView(backgroundColor: curiPalette(.blue500), placeholderHighlightName: placeholderHighlightName, highlightName: $nameHighlightPrimary, viewIsPresented: $renameHighlightPrimaryView, autoFocus: _autoFocusRename)
            }
            
            if renameHighlightSecondaryView {
                RenameHighlightView(backgroundColor: curiPalette(.pink500), placeholderHighlightName: placeholderHighlightName, highlightName: $nameHighlightSecondary, viewIsPresented: $renameHighlightSecondaryView, autoFocus: _autoFocusRename)
            }
        })
        .alert(isPresented: $deleteAlertIsPresented) {
            Alert(title: Text("Delete Quote and Note?"),
                  message: Text("Are you sure you want to delete the quote and the note?"),
                  primaryButton: .cancel(),
                  secondaryButton: .destructive(Text("Delete"), action: {
                print("Deleted!")
            }))
        }

    }
}

#Preview {
    @Previewable @Bindable var bookViewModel = BookViewModel()
    let bookIDFake = UUID()
    BookView(bookViewModel: bookViewModel, bookID: bookIDFake, bookTitle: "Harry Pọt tơ", bookLinesOriginal: [
        "FROM off a hill whose concave womb reworded",
        "A plaintful story from a sistering vale,",
        "My spirits to attend this double voice accorded,",
        "And down I laid to list the sad-tuned tale;"
    ], nameHighlightPrimary: .constant("Discuss Later"), nameHighlightSecondary: .constant("Good Point"), placeholderHighlightName: "Your highlight name", renameHighlightPrimaryView: .constant(false), renameHighlightSecondaryView: .constant(false))
}

struct LinesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var highlightDatabase: [Highlight]
    
    var bookID: UUID
    var bookTitle: String
    var bookLinesOriginal: [String]
    
    var body: some View {
        VStack (spacing: 8) {
            //                            ForEach(bookLines.indices, id: \.self) { index in
            //                                Text(bookLines[index])
            //                                    .frame(maxWidth: .infinity, alignment: .leading)
            //                                    .onLongPressGesture (minimumDuration: 0.2) {
            //                                        // Check in Database and Highlight
            //                                        let highlightedText = bookViewModel.highlightChecker(for: bookLines[index], highlightColor: curiPalette(.blue100), textColor: curiPalette(.blue500))
            //                                        withAnimation(.easeOut(duration: 0.1)) {
            //                                            bookLines[index] = highlightedText
            //                                        }
            //
            //                                        print("🙈 Line \([index]): \(highlightedText)")
            //                                    }
            //                                    .sheet(isPresented: $thoughtSheetIsPresented) {
            //                                        QuoteNoteSheetView(bookViewModel: bookViewModel, highlight: bookLines[index])
            //                                    }
            ////                                                            .background(Color.red) // Check section
            //                            }
            ForEach(bookLinesOriginal, id: \.self) { line in
                Text("\(line)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        let newHighlight = Highlight(bookID: bookID, bookTitle: bookTitle, highlight: line)
//                        highlightDatabase.insert(newHighlight)
//                        print("Highligh Database: \(highlightDatabase)")
//                        modelContext.insert(newHighlight)
                        print("\(highlightDatabase)")
                        print("Book ID: \(newHighlight.bookID)")
                        print("Highlight ID: \(newHighlight.highlightID)")
                        print("Book: \(newHighlight.bookTitle)")
                        print("Lines: \(newHighlight.highlight)")
                    }
//                    .foregroundStyle(bookViewModel.highlightDatabase.contains(line) ? curiPalette(.blue500) : curiPalette(.ink500))
            }
        }
    }
}
