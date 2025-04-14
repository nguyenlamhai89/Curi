//
//  Highlight.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 3/3/25.
//

import SwiftUI

@Observable
class HighlightPen {
    var defaultName: String
    
    var selectedTextColor: Color
    var selectedBackgroundColor: Color
    
    var isPresentedRenameView: Bool = false
    
    var unselectedTextColor: Color
    var unselectedBackgroundColor: Color
    
    var highlightedTextColor: Color?
    var unselectedHighlightedBackgroundColor: Color?
    var selectedHighlightedBackgroundColor: Color?
    
    init(defaultName: String, selectedTextColor: Color, selectedBackgroundColor: Color, unselectedTextColor: Color, unselectedBackgroundColor: Color, highlightedTextColor: Color? = nil, unselectedHighlightedBackgroundColor: Color? = nil, selectedHighlightedBackgroundColor: Color? = nil) {
        self.defaultName = defaultName
        self.selectedTextColor = selectedTextColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.unselectedTextColor = unselectedTextColor
        self.unselectedBackgroundColor = unselectedBackgroundColor
        self.highlightedTextColor = highlightedTextColor
        self.unselectedHighlightedBackgroundColor = unselectedHighlightedBackgroundColor
        self.selectedHighlightedBackgroundColor = selectedHighlightedBackgroundColor
    }
}

struct HighlightDial: View {
    var highlightPenStorage: [HighlightPen] = [
        HighlightPen(defaultName: "Discuss Later",
                     selectedTextColor: Color.paper500,
                     selectedBackgroundColor: Color.blue300,
                     unselectedTextColor: Color.blue500,
                     unselectedBackgroundColor: Color.blue100,
                     highlightedTextColor: Color.blue500,
                     unselectedHighlightedBackgroundColor: Color.blue100,
                     selectedHighlightedBackgroundColor: Color.blue200),
        HighlightPen(defaultName: "Good Point",
                     selectedTextColor: Color.paper500,
                     selectedBackgroundColor: Color.pink300,
                     unselectedTextColor: Color.pink500,
                     unselectedBackgroundColor: Color.pink100,
                     highlightedTextColor: Color.pink500,
                     unselectedHighlightedBackgroundColor: Color.pink100,
                     selectedHighlightedBackgroundColor: Color.pink200)
    ]
    @State private var selectedIndex: Int = 0
    
    var quoteIsSelected: Bool
    @Binding var thoughtSheetIsPresented: Bool
    @Binding var deleteAlertIsPresented: Bool
    @Binding var renameViewPrimary: Bool
    @Binding var renameViewSecondary: Bool
    
    var highlightName1: String
    var highlightName2: String
    
    
    var body: some View {
        VStack (spacing: curiSpacing(.sp8)) {
            HStack (spacing: curiSpacing(.sp8)) {
                if quoteIsSelected {
                    IconButtonDefault(iconName: "curiThought", action: {
                        withAnimation {
                            thoughtSheetIsPresented.toggle()
                        }
                        print("Thought Sheet On: \(thoughtSheetIsPresented)")
                    })
                } else {
                    Rectangle()
                        .fill(curiPalette(.paper500))
                        .frame(width: 32, height: 32)
                }
                
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
                                    ForEach(highlightPenStorage.indices, id: \.self) { penIndex in
                                        let isSelected = selectedIndex == penIndex
                                        
                                        HighlightButtonBook(name: highlightPenStorage[penIndex].defaultName,
                                                            buttonWidth: cardWidth,
                                                            selectedTextColor: highlightPenStorage[penIndex].selectedTextColor,
                                                            selectedBackgroundColor: highlightPenStorage[penIndex].selectedBackgroundColor,
                                                            unselectedTextColor: highlightPenStorage[penIndex].unselectedTextColor,
                                                            unselectedBackgroundColor: highlightPenStorage[penIndex].unselectedBackgroundColor,
                                                            isSelected: isSelected,
                                                            renameViewIsPresented: highlightPenStorage[penIndex].isPresentedRenameView) {
                                            
                                            highlightPenStorage[penIndex].isPresentedRenameView.toggle()
                                            
                                        }
                                    }
                                }
                                .padding(.horizontal, (geometry.size.width - cardWidth) / 2 - spacing / 2)
                                .gesture(
                                    DragGesture()
                                        .onEnded { value in
                                            let direction = value.translation.width
                                            
                                            if direction < -dragThreshold, selectedIndex < highlightPenStorage.count - 1 {
                                                selectedIndex += 1
                                            } else if direction > dragThreshold, selectedIndex > 0 {
                                                selectedIndex -= 1
                                            }
                                            
                                            withAnimation(.interpolatingSpring(stiffness: 150, damping: 15)) {
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
                
                if quoteIsSelected {
                    IconButtonDefault(iconName: "curiDelete", action: {
                        withAnimation {
                            deleteAlertIsPresented.toggle()
                        }
                        print("Delete Pressed")
                    })
                } else {
                    Rectangle()
                        .fill(curiPalette(.paper500))
                        .frame(width: 32, height: 32)
                }
                
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
    var content: String
    
    var body: some View {
        Text("\(content)")
            .curiTypo(.sfMedium14)
            .foregroundStyle(curiPalette(.paper500))
            .padding(.vertical, curiSpacing(.sp2))
            .padding(.horizontal, curiSpacing(.sp8))
            .background(curiPalette(.blue300))
            .cornerRadius(curiRadius(.rd4))
//            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    @Previewable @State var thoughtSheetIsPresented: Bool = false
    @Previewable @State var deleteAlertIsPresented: Bool = false
    @Previewable @State var renameHighlightViewIsPresented1: Bool = false
    @Previewable @State var renameHighlightViewIsPresented2: Bool = false
    @Previewable @State var tagNameDemoBlue: String = "Discuss Later"
    @Previewable @State var tagNameDemoPink: String = "Good"
    
    HighlightDial(quoteIsSelected: true, thoughtSheetIsPresented: $thoughtSheetIsPresented, deleteAlertIsPresented: $deleteAlertIsPresented, renameViewPrimary: $renameHighlightViewIsPresented1, renameViewSecondary: $renameHighlightViewIsPresented2, highlightName1: tagNameDemoBlue, highlightName2: tagNameDemoPink)

    HighlightDial(quoteIsSelected: false, thoughtSheetIsPresented: $thoughtSheetIsPresented, deleteAlertIsPresented: $deleteAlertIsPresented, renameViewPrimary: $renameHighlightViewIsPresented1, renameViewSecondary: $renameHighlightViewIsPresented2, highlightName1: tagNameDemoBlue, highlightName2: tagNameDemoPink)
    
//    HighlightButton(content: tagNameDemoBlue, color: Color.blue, action: {
//        print("Highlight Button Pressed")
//    })
    
    HighlightTag(content: tagNameDemoPink)
    
    HighlightQuotePaperButton(content: tagNameDemoBlue, color: Color.blue) {
        print("Highlight Quote Paper Button")
    }
}
