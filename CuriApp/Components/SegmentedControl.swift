//
//  SegmentedControl.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 27/2/25.
//

import SwiftUI

struct SegmentedButton: View {
    @ObservedObject var bookViewModel: BookViewModel
    var isSelected: Bool
    var content: String
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light, vibrationEnabledInApp: bookViewModel.vibrationInApp)
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
    @ObservedObject var bookViewModel: BookViewModel
    @Binding var pageOneIsSelected: Bool
    @Binding var pageTwoIsSelected: Bool
    
    var body: some View {
        HStack (spacing: curiSpacing(.sp4)) {
            SegmentedButton(bookViewModel: bookViewModel, isSelected: pageOneIsSelected, content: "Library") {
                if !pageOneIsSelected && pageTwoIsSelected {
                    switchState()
                    print("Page One Active: \(pageOneIsSelected)")
                    print("Page Two Active: \(pageTwoIsSelected)")
                } else {
                    return
                }
            }
            SegmentedButton(bookViewModel: bookViewModel, isSelected: pageTwoIsSelected, content: "Quote") {
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
    @Previewable @StateObject var bookViewModel = BookViewModel()
    @Previewable @State var pageOneIsSelected: Bool = true
    @Previewable @State var pageTwoIsSelected: Bool = false
    
    SegmentedControl(bookViewModel: bookViewModel, pageOneIsSelected: $pageOneIsSelected, pageTwoIsSelected: $pageTwoIsSelected)
}
