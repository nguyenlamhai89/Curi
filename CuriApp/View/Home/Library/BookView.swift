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
    
    var body: some View {
        VStack {
            // Navigation
            TopNavigationBook(quoteIsSelected: quoteSelected)
            
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
                quoteSelected.toggle()
            }
            
            // Highlight
            HighlightDial(quoteIsSelected: quoteSelected, thoughtSheetIsPresented: $thoughtSheetIsPresented, deleteAlertIsPresented: $deleteAlertIsPresented)
            .frame(height: 80)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, curiSpacing(.sp16))
        }
        .background(curiPalette(.paper500))
        .navigationBarHidden(true)
        .sheet(isPresented: $thoughtSheetIsPresented) {
            QuoteNoteSheetView()
        }
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
    BookView()
}
