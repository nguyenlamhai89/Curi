//
//  BookView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 5/3/25.
//

import SwiftUI

struct BookView: View {
    // Local
    @State var quoteSelected: Bool = true
    @State var thoughtSheetIsPresented: Bool = false
    @State var deleteAlertIsPresented: Bool = false
    @FocusState private var autoFocusRename: Bool
    
    @EnvironmentObject var bookViewModel: BookViewModel
    
    var bookTitle: String
    @State var bookLines: [AttributedString]
    
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
                        VStack (spacing: 8) {
                            ForEach(bookLines.indices, id: \.self) { index in
                                Text(bookLines[index])
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .onLongPressGesture (minimumDuration: 0.2) {
                                        
                                        // Check Highlight and Database
                                        let highlightedText = bookViewModel.highlightChecker(for: bookLines[index], highlightColor: curiPalette(.blue100), textColor: curiPalette(.blue500))
                                        withAnimation(.easeOut(duration: 0.2)) {
                                            bookLines[index] = highlightedText
                                        }
                                        
                                        // Haptics and Sound
                                        HapticsManager.access.play(haptics: .light)
                                        SoundManager.access.play(sound: .highlightFinished)
                                        
                                        print("🙈 Line \([index]): \(highlightedText)")
                                        print("⏲️ Database Details: \(bookViewModel.highlightDatabase)")
                                        print("📚 Count: \(bookViewModel.highlightDatabase.count)")
                                    }
//                                                            .background(Color.red) // Check section
                            }
                        }
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
        .sheet(isPresented: $thoughtSheetIsPresented) {
            QuoteNoteSheetView()
        }
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
    BookView(bookTitle: "Harry Pọt tơ", bookLines: [
        "FROM off a hill whose concave womb reworded",
              "A plaintful story from a sistering vale,",
              "My spirits to attend this double voice accorded,",
              "And down I laid to list the sad-tuned tale;"
    ], nameHighlightPrimary: .constant("Discuss Later"), nameHighlightSecondary: .constant("Good Point"), placeholderHighlightName: "Your highlight name", renameHighlightPrimaryView: .constant(false), renameHighlightSecondaryView: .constant(false))
}
