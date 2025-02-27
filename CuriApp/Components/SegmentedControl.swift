//
//  SegmentedControl.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 27/2/25.
//

import SwiftUI

struct SegmentedControl: View {
    var content1: String
    var content2: String
    
    var action1: () -> Void
    var action2: () -> Void
    
    var body: some View {
        HStack (spacing: curiSpacing(.sp4)) {
            Button {
                action1()
            } label: {
                Text(content1)
                    .curiTypo(.sfMedium14)
                    .foregroundStyle(curiPalette(.ink500))
                    .padding(.vertical, curiSpacing(.sp2))
                    .padding(.horizontal, curiSpacing(.sp8))
                    .background(curiPalette(.paper500))
                    .cornerRadius(curiRadius(.rdMax))
            }
            Button {
                action2()
            } label: {
                Text(content2)
                    .curiTypo(.sfMedium14)
                    .foregroundStyle(curiPalette(.paper500))
                    .padding(.vertical, curiSpacing(.sp2))
                    .padding(.horizontal, curiSpacing(.sp8))
                    .background(curiPalette(.ink100))
                    .cornerRadius(curiRadius(.rdMax))
            }
        }
        .padding(curiSpacing(.sp4))
        .background(curiPalette(.ink100))
        .cornerRadius(curiRadius(.rdMax))
    }
}

#Preview {
    SegmentedControl(content1: "Library", content2: "Quote") {
        print("Button 1 Pressed")
    } action2: {
        print("Button 2 Pressed")
    }
}
