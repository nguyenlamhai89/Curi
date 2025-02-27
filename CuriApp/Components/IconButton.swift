//
//  IconButton.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 27/2/25.
//

import SwiftUI

struct IconButtonDefault: View {
    var iconName: String
    
    var body: some View {
        Image(iconName)
            .resizable()
            .scaledToFit()
            .frame(width: 24)
            .padding(curiSpacing(.sp4))
            .background(curiPalette(.ink100))
            .cornerRadius(curiRadius(.rdMax))
    }
}

struct IconButtonActive: View {
    var iconName: String
    
    var body: some View {
        Image(iconName)
            .resizable()
            .scaledToFit()
            .frame(width: 24)
            .padding(curiSpacing(.sp4))
            .background(curiPalette(.ink300))
            .cornerRadius(curiRadius(.rdMax))
    }
}

struct IconButtonApp: View {
    var iconName: String
    
    var body: some View {
        Image(iconName)
            .resizable()
            .scaledToFit()
            .frame(width: 24)
            .padding(curiSpacing(.sp4))
            .cornerRadius(curiRadius(.rdMax))
    }
}

#Preview {
    HStack {
        IconButtonDefault(iconName: "curiThought")
        IconButtonActive(iconName: "curiThought")
        IconButtonApp(iconName: "curiLeft")
    }
    
}
