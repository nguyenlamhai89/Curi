//
//  WidgetIntroducingView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 5/4/25.
//

import SwiftUI

struct WidgetIntroducingView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    WidgetIntroducingView()
}
