//
//  Highlight.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 3/3/25.
//

import SwiftUI

struct HighlightDial: View {
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
                    // Highlight Buttons
                    GeometryReader { geometry in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: curiSpacing(.sp8)) {
                                HighlightButton(content: highlightName1, color: curiPalette(.blue300), action: {
                                    withAnimation {
                                        renameViewPrimary.toggle()
                                        print("Blue Pressed")
                                    }
                                })
                                
                                HighlightButton(content: highlightName2, color: curiPalette(.pink300), action: {
                                    withAnimation {
                                        renameViewSecondary.toggle()
                                        print("Pink Pressed")
                                    }
                                })
                            }
                            .padding(.horizontal, geometry.size.width * 0.4)
                            .scrollTargetLayout()
                        }
                    }
                    .scrollTargetBehavior(.viewAligned)
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

struct HighlightButton: View {
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
                .curiTypo(.sfMedium16)
                .foregroundStyle(curiPalette(.paper500))
                .padding(.vertical, curiSpacing(.sp2))
                .padding(.horizontal, curiSpacing(.sp8))
                .background(color)
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
    
    HighlightButton(content: tagNameDemoBlue, color: Color.blue, action: {
        print("Highlight Button Pressed")
    })
    
    HighlightTag(content: tagNameDemoPink)
    
    HighlightQuotePaperButton(content: tagNameDemoBlue, color: Color.blue) {
        print("Highlight Quote Paper Button")
    }
}
