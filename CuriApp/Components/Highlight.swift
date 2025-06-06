//
//  Highlight.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 3/3/25.
//

import SwiftUI
import SwiftData
import Mixpanel

struct HighlightDial: View {
    @Environment(\.modelContext) var modelContext
    @ObservedObject var bookViewModel: BookViewModel
    @Query var quoteDatabase: [Quote]
    @Query var pencilDatabase: [HighlightPencil]
    @Query var userSettings: [User]
    
    @Binding var thoughtSheetIsPresented: Bool
    
    @State var startReadingTime: Date?
    
    var selectedLineHasNote: Bool {
        bookViewModel.selectedLine?.quoteNote?.hasContent ?? false
    }

    var selectedLineHasQuote: Bool {
        !(bookViewModel.selectedLine?.quoteContent ?? "").isEmpty
    }
    
    var actionRename: () -> Void
    var actionDelete: () -> Void
    
    var body: some View {
        VStack (spacing: curiSpacing(.sp8)) {
            HStack (spacing: curiSpacing(.sp8)) {
                ZStack {
                    if selectedLineHasQuote {
                        IconButton(
                            bookViewModel: bookViewModel,
                            iconName: "curiThought",
                            hasNote: selectedLineHasNote,
                            action: {
                                thoughtSheetIsPresented.toggle()
                                Mixpanel.mainInstance().track(event: "thinkQuote_OnDial")
                                print("Thought Sheet On: \(thoughtSheetIsPresented)")
                            }
                        )
                    } else {
                        Rectangle()
                            .fill(curiPalette(.paper500))
                            .frame(width: 32, height: 32)
                    }
                }
                .animation(.easeInOut, value: bookViewModel.selectedLine?.quoteContent)
                
                // Highlight Dial
                Rectangle()
                    .fill(curiPalette(.paper500))
                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
                .overlay {
                    //Dial Line
                    HStack (spacing: curiSpacing(.sp16)) {
                        ForEach(0..<20) { _ in
                            Rectangle()
                                .fill(curiPalette(.ink100))
                                .frame(width: 1.6, height: 16)
                        }
                    }
                }
                .overlay {
                    GeometryReader { geometry in
                        let cardWidth = geometry.size.width * 0.5
                        let spacing: CGFloat = curiSpacing(.sp8)
                        let dragThreshold: CGFloat = 100
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            ScrollViewReader { scrollProxy in
                                HStack(spacing: spacing) {
                                    ForEach(pencilDatabase.indices, id: \.self) { penIndex in
                                        let isSelected = bookViewModel.selectedIndex == penIndex
                                        
                                        HighlightButtonBook(bookViewModel: bookViewModel,
                                                            name: pencilDatabase[penIndex].name,
                                                            buttonWidth: cardWidth,
                                                            selectedTextColor: Color(pencilDatabase[penIndex].primaryTextColor),
                                                            selectedBackgroundColor: Color(pencilDatabase[penIndex].primaryBackgroundColor),
                                                            unselectedTextColor: Color(pencilDatabase[penIndex].secondaryTextColor),
                                                            unselectedBackgroundColor: Color(pencilDatabase[penIndex].secondaryBackgroundColor),
                                                            isSelected: isSelected,
                                                            renameViewIsPresented: pencilDatabase[penIndex].isPresentedRenameView) {
                                            actionRename()
                                        }
                                    }
                                }
                                .padding(.horizontal, (geometry.size.width - cardWidth) / 2 - spacing / 2)
                                .gesture(
                                    DragGesture()
                                        .onEnded { value in
                                            let direction = value.translation.width
                                            
                                            if direction < -dragThreshold, bookViewModel.selectedIndex < pencilDatabase.count - 1 {
                                                bookViewModel.selectedIndex += 1
                                                HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
                                                bookViewModel.selectedPen = pencilDatabase[bookViewModel.selectedIndex]
                                            } else if direction > dragThreshold, bookViewModel.selectedIndex > 0 {
                                                bookViewModel.selectedIndex -= 1
                                                HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
                                                bookViewModel.selectedPen = pencilDatabase[bookViewModel.selectedIndex]
                                            }
                                            
                                            bookViewModel.selectedLine?.quoteHighlight = bookViewModel.selectedPen!
                                            bookViewModel.quoteChangedTrigger = UUID()
                                            bookViewModel.lastSyncedTime = Date()
                                            
                                            withAnimation {
                                                scrollProxy.scrollTo(bookViewModel.selectedIndex, anchor: .center)
                                            }
                                            Mixpanel.mainInstance().track(event: "change_HighlightPencil")
                                        }
                                )
                                .simultaneousGesture(DragGesture())
                                .onAppear {
                                    if pencilDatabase.count > 0 {
                                        scrollProxy.scrollTo(bookViewModel.selectedIndex, anchor: .center)
                                        bookViewModel.selectedPen = pencilDatabase[bookViewModel.selectedIndex]
                                        print("Selected Index: \(bookViewModel.selectedIndex) - \(String(describing: bookViewModel.selectedPen))")
                                        
                                        startReadingTime = Date()
                                        print("Book Opened")
                                    }
                                    
                                }
                                .onDisappear {
                                    if let startReadingTime = startReadingTime {
                                        let readingDuration = Date().timeIntervalSince(startReadingTime)
                                        if let thisUser = userSettings.first {
                                            thisUser.totalReadTime += readingDuration
                                            try? modelContext.save()
                                            print("Total Reading Time: \(thisUser.totalReadTime)")
                                        } else {
                                            print("-- Nil!")
                                        }
                                    }
                                    print("Book Closed")
                                    
                                }
                                .onChange(of: bookViewModel.selectedPen) {
                                    print("On Selected - \(String(describing: bookViewModel.selectedPen?.name))")
                                }
                                .onChange(of: bookViewModel.selectedLine) {
                                    if let selectedHighlight = bookViewModel.selectedLine?.quoteHighlight,
                                       let index = pencilDatabase.firstIndex(where: { $0.id == selectedHighlight.id }) {
                                        bookViewModel.selectedIndex = index
                                        bookViewModel.selectedPen = pencilDatabase[bookViewModel.selectedIndex]
                                        withAnimation {
                                            scrollProxy.scrollTo(bookViewModel.selectedIndex, anchor: .center)
                                        }
                                    }
                                }
                                .onChange(of: bookViewModel.quoteChangedTrigger) {
                                    bookViewModel.updateQOTD(quoteDatabase: quoteDatabase)
                                }
                            }
                        }
                    }
                }
                .overlay {
                    // Gradient Block
                    HStack {
                        LinearGradient(colors: [curiPalette(.paper500), curiPalette(.paper500).opacity(0)], startPoint: .leading, endPoint: .trailing)
                            .frame(width: 32)
                        Spacer()
                        LinearGradient(colors: [curiPalette(.paper500), curiPalette(.paper500).opacity(0)], startPoint: .trailing, endPoint: .leading)
                            .frame(width: 32)
                    }
                }
                .clipped()
                
                ZStack {
                    if selectedLineHasQuote {
                        IconButton(bookViewModel: bookViewModel, iconName: "curiDelete", hasNote: false) {
                            actionDelete()
                            Mixpanel.mainInstance().track(event: "deleteQuote_OnDial")
                            print("Delete Pressed")
                        }
//                        .transition(.scale.combined(with: .opacity))
                    } else {
                        Rectangle()
                            .fill(curiPalette(.paper500))
                            .frame(width: 32, height: 32)
//                            .transition(.scale.combined(with: .opacity))
                    }
                }
                .animation(.easeInOut, value: bookViewModel.selectedLine?.quoteContent)
                
            }
            
            Text("Swipe to change Highlight. Tap to rename.")
                .curiTypo(.sfMedium12)
                .foregroundStyle(curiPalette(.ink100))
            
        }
    }
}

struct HighlightButtonBook: View {
    @ObservedObject var bookViewModel: BookViewModel
    var name: String
    var buttonWidth: CGFloat
    
    var selectedTextColor: Color
    var selectedBackgroundColor: Color
    var unselectedTextColor: Color
    var unselectedBackgroundColor: Color
    
    var isSelected: Bool
    
    var renameViewIsPresented: Bool
    
    var action: () -> Void
    
    var body: some View {
        Button {
            SoundManager.access.play(sound: .highlightRename, soundEnabledInApp: bookViewModel.soundInApp)
            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
            action()
        } label: {
            Text("\(name)")
                .curiTypo(.sfMedium16)
                .foregroundStyle(isSelected ? selectedTextColor : unselectedTextColor)
                .padding(.vertical, curiSpacing(.sp2))
                .padding(.horizontal, curiSpacing(.sp8))
                .frame(width: buttonWidth)
                .background(isSelected ? selectedBackgroundColor : unselectedBackgroundColor)
                .cornerRadius(curiRadius(.rd4))
        }
    }
}

struct HighlightQuotePaperButton: View {
    @ObservedObject var bookViewModel: BookViewModel
    var content: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button {
            SoundManager.access.play(sound: .highlightRename, soundEnabledInApp: bookViewModel.soundInApp)
            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
            action()
        } label: {
            Text("\(content)")
                .curiTypo(.sfMedium14)
                .foregroundStyle(curiPalette(.paper500))
                .padding(.top, curiSpacing(.sp2))
                .padding(.bottom, curiSpacing(.sp16))
                .padding(.horizontal, curiSpacing(.sp8))
                .frame(width: 240)
                .background(color)
                .cornerRadius(curiRadius(.rd8))
        }
    }
}

struct HighlightTag: View {
    var highlightName: String
    var highlightColor: String
    
    var body: some View {
        Text("\(highlightName)")
            .curiTypo(.sfMedium14)
            .foregroundStyle(curiPalette(.paper500))
            .padding(.vertical, curiSpacing(.sp2))
            .padding(.horizontal, curiSpacing(.sp8))
            .background(Color(highlightColor))
            .cornerRadius(curiRadius(.rd4))
//            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
