//
//  BookView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 5/3/25.
//

import SwiftUI

struct BookView: View {
    @State var quoteSelected: Bool = true
    @State var thoughtSheetIsPresented: Bool = false
    @State var deleteAlertIsPresented: Bool = false
    @State var tagNameDemo: String = "Discuss Later"
    @State var renameHighlightViewIsPresented: Bool = false
    
    var bookName: String
    
    @FocusState private var autoFocusRename: Bool
    
    var body: some View {
        VStack {
            // Navigation
            TopNavigationBook(quoteIsSelected: quoteSelected, bookName: bookName)
            
            // Book conent
            VStack (spacing: curiSpacing(.sp20)) {
                Text("Sonnet 3: Look in thy glass and tell the face thou viewest")
                    .curiTypo(.bkBold16)
                    .multilineTextAlignment(.center)
                Text("Look in thy glass and tell the face thou viewest. Now is the time that face should form another; Whose fresh repair if now thou not renewest, Thou dost beguile the world, unbless some mother.")
                    .curiTypo(.bkRegular16)
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .padding(.vertical, 16)
            .padding(.horizontal, 32)
            .background(curiPalette(.paper500))
            .onTapGesture {
                withAnimation {
                    quoteSelected.toggle()
                }
            }
            
            // Highlight
            HighlightDial(quoteIsSelected: quoteSelected, thoughtSheetIsPresented: $thoughtSheetIsPresented, deleteAlertIsPresented: $deleteAlertIsPresented, renameHighlightViewIsPresented: $renameHighlightViewIsPresented, tagName: tagNameDemo)
                .bottomNavigationSpacing
        }
        .background(curiPalette(.paper500))
        .navigationBarHidden(true)
        .sheet(isPresented: $thoughtSheetIsPresented) {
            QuoteNoteSheetView()
        }
        
        /// Change Name View
        .overlay(content: {
            if renameHighlightViewIsPresented {
                Rectangle()
                    .fill(curiPalette(.blue500))
                    .ignoresSafeArea()
                    .overlay {
                        VStack (spacing: curiSpacing(.sp2)) {
                            TextField("Blue", text: $tagNameDemo)
                                .curiTypo(.sfRegular32)
                                .foregroundStyle(curiPalette(.paper500))
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                                .focused($autoFocusRename)
                                .submitLabel(.done)
                                .onSubmit {
                                    withAnimation {
                                        renameHighlightViewIsPresented.toggle()
                                        print("Rename View On: \(renameHighlightViewIsPresented)")
                                    }
                                }
                                .onChange(of: tagNameDemo) { oldValue, newValue in
                                    tagNameDemo = newValue.prefix(20).description
                                }
                            Text("\(tagNameDemo.count)")
                                .curiTypo(.sfMedium12)
                                .foregroundStyle(curiPalette(.paper500))
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            autoFocusRename = true
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

#Preview {
    BookView(bookName: "Test")
}
