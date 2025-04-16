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
    @State var quoteSelected: Bool = true
    @State var thoughtSheetIsPresented: Bool = false
    @State var deleteAlertIsPresented: Bool = false
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
                    quoteSelected.toggle()
                }
            }
            
            VStack {
                // Navigation
                TopNavigationBook(quoteIsSelected: quoteSelected)
//                    .background(Color.blue)
                
                Spacer()
                
                // Highlight
                HighlightDial(bookViewModel: bookViewModel, thoughtSheetIsPresented: $thoughtSheetIsPresented, deleteAlertIsPresented: $deleteAlertIsPresented, quoteIsSelected: false) {
                    isPresentedRenameView.toggle()
                }
                .bottomNavigationSpacing
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
