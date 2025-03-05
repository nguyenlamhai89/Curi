//
//  Highlight.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 3/3/25.
//

import SwiftUI

struct HighlighDial: View {
    var body: some View {
        HStack (spacing: curiSpacing(.sp8)) {
            IconButtonDefault(iconName: "curiThought", action: {
                print("Thought Pressed")
            })
            
            // Highlight Dial
            HStack {
                ZStack {
                    //Dial Line
                    HStack (spacing: curiSpacing(.sp20)) {
                        ForEach(0..<20) { _ in
                            Rectangle()
                                .fill(curiPalette(.ink100))
                                .frame(width: 1.6, height: 16)
                        }
                    }
                    
                    // Highlight Buttons
                    HStack (spacing: curiSpacing(.sp8)) {
                        HighlightButton(content: "Discuss Later", action: {
                            print("Blue Pressed")
                        })
                        HighlightButton(content: "Good Point", action: {
                            print("Pink Pressed")
                        })
                    }
                    
                    // Gradient Block
                    HStack {
                        LinearGradient(colors: [curiPalette(.paper500), curiPalette(.paper500).opacity(0)], startPoint: .leading, endPoint: .trailing)
                            .frame(width: 32)
                        Spacer()
                        LinearGradient(colors: [curiPalette(.paper500), curiPalette(.paper500).opacity(0)], startPoint: .trailing, endPoint: .leading)
                            .frame(width: 32)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
            .background(Color.yellow)
            .clipped()
            
            
            
            IconButtonDefault(iconName: "curiDelete", action: {
                print("Delete Pressed")
            })
        }
    }
}

struct HighlightButton: View {
    var content: String
    var action: () -> Void
    
    var body: some View {
        Button {
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
    HighlighDial()
    HighlightButton(content: "Discuss Later", action: {
        print("Highlight Button Pressed")
    })
    HighlightTag(content: "Discuss Later")
}
