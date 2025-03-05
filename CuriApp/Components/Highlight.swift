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
    @Binding var renameHighlightViewIsPresented: Bool
    
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
                    HStack (spacing: curiSpacing(.sp8)) {
                        HighlightButton(content: "Discuss Later", action: {
                            withAnimation {
                                renameHighlightViewIsPresented.toggle()
                                print("Blue Pressed")
                            }
                        })
//                        HighlightButton(content: "Good Point", action: {
//                            print("Pink Pressed")
//                        })
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
                        deleteAlertIsPresented.toggle()
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
                .background(content=="Discuss Later" ? curiPalette(.blue300) : curiPalette(.pink300))
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
    @Previewable @State var renameHighlightViewIsPresented: Bool = false

    HighlightDial(quoteIsSelected: true, thoughtSheetIsPresented: $thoughtSheetIsPresented, deleteAlertIsPresented: $deleteAlertIsPresented, renameHighlightViewIsPresented: $renameHighlightViewIsPresented)
    HighlightButton(content: "Discuss Later", action: {
        print("Highlight Button Pressed")
    })
    HighlightTag(content: "Discuss Later")
}
