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
    
    var sampleBookChapter: String
    var sampleBookContent: [String]
//    var sampleBookChapter: String = "Sonnet 19: Devouring Time, blunt thou the lion's paws"
//    var sampleBookContent: [String] = [
//        "Devouring Time, blunt thou the lion's paws,",
//        "And make the earth devour her own sweet brood;",
//        "Pluck the keen teeth from the fierce tiger's jaws,",
//        "And burn the long-liv'd phoenix, in her blood;",
//        "Make glad and sorry seasons as thou fleets,",
//        "And do whate'er thou wilt, swift-footed Time,",
//        "To the wide world and all her fading sweets;",
//        "But I forbid thee one most heinous crime:",
//        "O! carve not with thy hours my love's fair brow,",
//        "Nor draw no lines there with thine antique pen;",
//        "Him in thy course untainted do allow",
//        "For beauty's pattern to succeeding men.",
//        "Yet, do thy worst old Time: despite thy wrong,",
//        "My love shall in my verse ever live young."
//    ]
    
    // Binding from HomeView
    @Binding var nameHighlightPrimary: String
    @Binding var nameHighlightSecondary: String
    var placeholderHighlightName: String
    @Binding var renameHighlightPrimaryView: Bool
    @Binding var renameHighlightSecondaryView: Bool
    var bookNameAtNavigationForEach: String
    
    var body: some View {
        VStack {
            // Navigation
            TopNavigationBook(quoteIsSelected: quoteSelected, bookName: bookNameAtNavigationForEach)
            
            // Book conent
            VStack (spacing: curiSpacing(.sp20)) {
                Text(sampleBookChapter)
                    .curiTypo(.bkBold16)
                    .multilineTextAlignment(.center)
                VStack (spacing: curiSpacing(.sp8)) {
                    ForEach(sampleBookContent, id: \.self) { content in
                        Text(content)
                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .background(Color.red) // Check section
                    }
                }
                .curiTypo(.bkRegular16)
//                .background(Color.green) // Check section
                
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
            HighlightDial(quoteIsSelected: quoteSelected, thoughtSheetIsPresented: $thoughtSheetIsPresented, deleteAlertIsPresented: $deleteAlertIsPresented, renameHighlightViewIsPresented1: $renameHighlightPrimaryView, renameHighlightViewIsPresented2: $renameHighlightSecondaryView, highlightName1: nameHighlightPrimary, highlightName2: nameHighlightSecondary)
                .bottomNavigationSpacing
        }
        .background(curiPalette(.paper500))
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
//    BookView(nameHighlightPrimary: .constant("Discuss Later"), nameHighlightSecondary: .constant("Good Point"), placeholderHighlightName: "Your highlight name", renameHighlightPrimaryView: .constant(false), renameHighlightSecondaryView: .constant(false), bookNameAtNavigationForEach: "Harry Potter")
    BookView(sampleBookChapter: "Harry Pọt tơ", sampleBookContent: ["Alo", "Bê đê"], nameHighlightPrimary: .constant("Discuss Later"), nameHighlightSecondary: .constant("Good Point"), placeholderHighlightName: "Your highlight name", renameHighlightPrimaryView: .constant(false), renameHighlightSecondaryView: .constant(false), bookNameAtNavigationForEach: "Harry Potter")
}
