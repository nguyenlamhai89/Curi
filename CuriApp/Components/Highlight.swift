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
    @Binding var renameHighlightViewIsPresented1: Bool
    @Binding var renameHighlightViewIsPresented2: Bool
    
    var highlightName1: String
    var highlightName2: String
    
    var body: some View {
        VStack (spacing: curiSpacing(.sp8)) {
            HStack (spacing: curiSpacing(.sp8)) {
                if quoteIsSelected {
                    IconButtonDefault(iconName: "curiThought", action: {
                        thoughtSheetIsPresented.toggle()
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
                    ScrollView(.horizontal) {
                        HStack (spacing: curiSpacing(.sp8)) {
                            HighlightButton(content: highlightName1, color: curiPalette(.blue300), action: {
                                withAnimation {
                                    renameHighlightViewIsPresented1.toggle()
                                    print("Blue Pressed")
                                }
                            })
                            HighlightButton(content: highlightName2, color: curiPalette(.pink300), action: {
                                withAnimation {
                                    renameHighlightViewIsPresented2.toggle()
                                    print("Pink Pressed")
                                }
                            })
                            
                            ////Samples
//                            HighlightButton(content: highlightName1, color: curiPalette(.blue500), action: {
//                                withAnimation {
//                                    renameHighlightViewIsPresented1.toggle()
//                                    print("Blue Pressed")
//                                }
//                            })
//                            HighlightButton(content: highlightName2, color: curiPalette(.pink500), action: {
//                                withAnimation {
//                                    renameHighlightViewIsPresented2.toggle()
//                                    print("Pink Pressed")
//                                }
//                            })
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
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
                        deleteAlertIsPresented.toggle()
                        print("Delete Pressed")
                    })
                } else {
                    Rectangle()
                        .fill(curiPalette(.paper500))
                        .frame(width: 32, height: 32)
                }
                
            }
            if quoteIsSelected {
                Text("Swipe to change Highlight. Tap to rename.")
                    .curiTypo(.sfMedium12)
                    .foregroundStyle(curiPalette(.ink100))
            } else {
                Rectangle()
                    .fill(curiPalette(.paper500))
                    .frame(maxWidth: .infinity, maxHeight: 16)
            }
            
        }
        
    }
}

struct HighlightButton: View {
    var content: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button {
            let impactFeedback = UIImpactFeedbackGenerator(style: .light)
            impactFeedback.impactOccurred()
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
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    @Previewable @State var thoughtSheetIsPresented: Bool = false
    @Previewable @State var deleteAlertIsPresented: Bool = false
    @Previewable @State var renameHighlightViewIsPresented1: Bool = false
    @Previewable @State var renameHighlightViewIsPresented2: Bool = false
    @Previewable @State var tagNameDemoBlue: String = "Discuss Later"
    @Previewable @State var tagNameDemoPink: String = "Good"

    HighlightDial(quoteIsSelected: true, thoughtSheetIsPresented: $thoughtSheetIsPresented, deleteAlertIsPresented: $deleteAlertIsPresented, renameHighlightViewIsPresented1: $renameHighlightViewIsPresented1, renameHighlightViewIsPresented2: $renameHighlightViewIsPresented2, highlightName1: tagNameDemoBlue, highlightName2: tagNameDemoPink)
    
    HighlightButton(content: tagNameDemoBlue, color: Color.blue, action: {
        print("Highlight Button Pressed")
    })
    
    HighlightTag(content: tagNameDemoPink)
}
