//
//  Highlight.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 3/3/25.
//

import SwiftUI
import SwiftData


struct HighlightDial: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var bookViewModel: BookViewModel
    @Query var pencilDatabase: [HighlightPencil]
    
    @State var selectedIndex: Int = 0
    @Binding var thoughtSheetIsPresented: Bool
    @Binding var deleteAlertIsPresented: Bool
    
    var action: () -> Void
    
    var body: some View {
        VStack (spacing: curiSpacing(.sp8)) {
            HStack (spacing: curiSpacing(.sp8)) {
                ZStack {
                    if let lineQuote = bookViewModel.selectedLine?.quoteContent, !lineQuote.isEmpty {
                        IconButtonDefault(iconName: "curiThought", action: {
                            withAnimation {
                                thoughtSheetIsPresented.toggle()
                            }
                            print("Thought Sheet On: \(thoughtSheetIsPresented)")
                        })
//                        .transition(.scale.combined(with: .opacity))
                    } else {
                        Rectangle()
                            .fill(curiPalette(.paper500))
                            .frame(width: 32, height: 32)
//                            .transition(.scale.combined(with: .opacity))
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
                                        let isSelected = selectedIndex == penIndex
                                        
                                        HighlightButtonBook(name: pencilDatabase[penIndex].name,
                                                            buttonWidth: cardWidth,
                                                            selectedTextColor: Color(pencilDatabase[penIndex].primaryTextColor),
                                                            selectedBackgroundColor: Color(pencilDatabase[penIndex].primaryBackgroundColor),
                                                            unselectedTextColor: Color(pencilDatabase[penIndex].secondaryTextColor),
                                                            unselectedBackgroundColor: Color(pencilDatabase[penIndex].secondaryBackgroundColor),
                                                            isSelected: isSelected,
                                                            renameViewIsPresented: pencilDatabase[penIndex].isPresentedRenameView) {
                                            action()
                                        }
                                    }
                                }
                                .padding(.horizontal, (geometry.size.width - cardWidth) / 2 - spacing / 2)
                                .gesture(
                                    DragGesture()
                                        .onEnded { value in
                                            let direction = value.translation.width
                                            
                                            if direction < -dragThreshold, selectedIndex < pencilDatabase.count - 1 {
                                                selectedIndex += 1
                                                HapticsManager.access.play(haptics: .light)
                                                bookViewModel.selectedPen = pencilDatabase[selectedIndex]
                                            } else if direction > dragThreshold, selectedIndex > 0 {
                                                selectedIndex -= 1
                                                HapticsManager.access.play(haptics: .light)
                                                bookViewModel.selectedPen = pencilDatabase[selectedIndex]
                                            }
                                            
                                            withAnimation {
                                                scrollProxy.scrollTo(selectedIndex, anchor: .center)
                                            }
                                        }
                                )
                                .onAppear {
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            scrollProxy.scrollTo(selectedIndex, anchor: .center)
                                        }
                                    }
                                    bookViewModel.selectedPen = pencilDatabase[selectedIndex]
                                }
                                .onChange(of: bookViewModel.selectedPen) {
                                    print("On Selected - \(String(describing: bookViewModel.selectedPen?.name))")
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
                    if let lineQuote = bookViewModel.selectedLine?.quoteContent, !lineQuote.isEmpty {
                        IconButtonDefault(iconName: "curiDelete", action: {
                            withAnimation {
                                deleteAlertIsPresented.toggle()
                            }
                            print("Delete Pressed")
                        })
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
            SoundManager.access.play(sound: .highlightRename)
            HapticsManager.access.play(haptics: .light)
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
    var content: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button {
            SoundManager.access.play(sound: .highlightRename)
            HapticsManager.access.play(haptics: .light)
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
