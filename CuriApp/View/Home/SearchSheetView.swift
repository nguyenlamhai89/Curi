//
//  SearchSheetView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI

struct SearchSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack (spacing: 0) {
            Text("Hello")
        }
        .background(curiPalette(.paper500))
    }
}

#Preview {
    SearchSheetView()
}
