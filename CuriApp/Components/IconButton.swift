//
//  IconButton.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 27/2/25.
//

import SwiftUI

struct IconButtonDefault: View {
    var iconName: String
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light)
            action()
        } label: {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 24)
                .padding(curiSpacing(.sp4))
                .background(curiPalette(.ink100))
                .cornerRadius(curiRadius(.rdMax))
        }
    }
}

struct IconButtonActive: View {
    var iconName: String
    var action: () -> Void
    
    var body: some View {
        Button {
            HapticsManager.access.play(haptics: .light)
            action()
        } label: {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 24)
                .padding(curiSpacing(.sp4))
                .background(curiPalette(.ink300))
                .cornerRadius(curiRadius(.rdMax))
        }
    }
}

struct IconButtonApp: View {
    var iconName: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 24)
                .padding(curiSpacing(.sp4))
                .cornerRadius(curiRadius(.rdMax))
        }
    }
}

#Preview {
    HStack {
        IconButtonDefault(iconName: "curiThought", action: {
            print("Thought 1")
        })
        IconButtonActive(iconName: "curiThought", action: {
            print("Thought 2")
        })
        IconButtonApp(iconName: "curiLeft", action: {
            print("Back")
        })
    }
    
}
