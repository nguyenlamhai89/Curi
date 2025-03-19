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
    var bookLines: [String]
    
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
                            ForEach(bookLines, id: \.self) { content in
                                Text(content)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .onTapGesture {
                                        SoundManager.access.play(sound: .highlightDone)
                                        print("Highlighted: \(content)")
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
              "And down I laid to list the sad-tuned tale;",
              "Ere long espied a fickle maid full pale,",
              "Tearing of papers, breaking rings a-twain,",
              "Storming her world with sorrow's wind and rain.",
              "",
              "Upon her head a platted hive of straw,",
              "Which fortified her visage from the sun,",
              "Whereon the thought might think sometime it saw",
              "The carcass of beauty spent and done:",
              "Time had not scythed all that youth begun,",
              "Nor youth all quit; but, spite of heaven's fell rage,",
              "Some beauty peep'd through lattice of sear'd age.",
              "",
              "Oft did she heave her napkin to her eyne,",
              "Which on it had conceited characters,",
              "Laundering the silken figures in the brine",
              "That season'd woe had pelleted in tears,",
              "And often reading what contents it bears;",
              "As often shrieking undistinguish'd woe,",
              "In clamours of all size, both high and low.",
              "",
              "Sometimes her levell'd eyes their carriage ride,",
              "As they did battery to the spheres intend;",
              "Sometime diverted their poor balls are tied",
              "To the orbed earth; sometimes they do extend",
              "Their view right on; anon their gazes lend",
              "To every place at once, and, nowhere fix'd,",
              "The mind and sight distractedly commix'd.",
              "",
              "Her hair, nor loose nor tied in formal plat,",
              "Proclaim'd in her a careless hand of pride",
              "For some, untuck'd, descended her sheaved hat,",
              "Hanging her pale and pined cheek beside;",
              "Some in her threaden fillet still did bide,",
              "And true to bondage would not break from thence,",
              "Though slackly braided in loose negligence.",
              "",
              "A thousand favours from a maund she drew",
              "Of amber, crystal, and of beaded jet,",
              "Which one by one she in a river threw,",
              "Upon whose weeping margent she was set;",
              "Like usury, applying wet to wet,",
              "Or monarch's hands that let not bounty fall",
              "Where want cries some, but where excess begs all.",
              "",
              "Of folded schedules had she many a one,",
              "Which she perused, sigh'd, tore, and gave the flood;",
              "Crack'd many a ring of posied gold and bone",
              "Bidding them find their sepulchres in mud;",
              "Found yet moe letters sadly penn'd in blood,",
              "With sleided silk feat and affectedly",
              "Enswathed, and seal'd to curious secrecy."
    ], nameHighlightPrimary: .constant("Discuss Later"), nameHighlightSecondary: .constant("Good Point"), placeholderHighlightName: "Your highlight name", renameHighlightPrimaryView: .constant(false), renameHighlightSecondaryView: .constant(false))
}
