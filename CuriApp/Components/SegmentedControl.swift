//
//  SegmentedControl.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 27/2/25.
//

import SwiftUI

struct SegmentedButton: View {
    var isSelected: Bool
    var content: String
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light)
            action()
        } label: {
            Text(content)
                .curiTypo(.sfMedium14)
                .foregroundStyle(isSelected ? curiPalette(.ink500) : curiPalette(.paper500))
                .padding(.vertical, curiSpacing(.sp2))
                .padding(.horizontal, curiSpacing(.sp8))
                .background(isSelected ? curiPalette(.paper500) : curiPalette(.ink100))
                .cornerRadius(curiRadius(.rdMax))
        }
    }
}

struct SegmentedControl: View {
    @Binding var pageOneIsSelected: Bool
    @Binding var pageTwoIsSelected: Bool
    
    var body: some View {
        HStack (spacing: curiSpacing(.sp4)) {
            SegmentedButton(isSelected: pageOneIsSelected, content: "Library") {
                if !pageOneIsSelected && pageTwoIsSelected {
                    switchState()
                    print("Page One Active: \(pageOneIsSelected)")
                    print("Page Two Active: \(pageTwoIsSelected)")
                } else {
                    return
                }
            }
            SegmentedButton(isSelected: pageTwoIsSelected, content: "Quote") {
                if pageOneIsSelected && !pageTwoIsSelected {
                    switchState()
                    print("Page One Active: \(pageOneIsSelected)")
                    print("Page Two Active: \(pageTwoIsSelected)")
                } else {
                    return
                }
            }
        }
        .padding(curiSpacing(.sp4))
        .background(curiPalette(.ink100))
        .cornerRadius(curiRadius(.rdMax))
    }
    
    func switchState() {
        pageOneIsSelected.toggle()
        pageTwoIsSelected.toggle()
    }
}

#Preview {
    @Previewable @State var pageOneIsSelected: Bool = true
    @Previewable @State var pageTwoIsSelected: Bool = false
    
    SegmentedControl(pageOneIsSelected: $pageOneIsSelected, pageTwoIsSelected: $pageTwoIsSelected)
}
