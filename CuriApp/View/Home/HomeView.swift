//
//  HomeView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI

struct HomeView: View {
    @Binding var settingsTopNavigation: Bool
    @Binding var searchTopNavigation: Bool
    
    var body: some View {
        ZStack {
            /// Top Navigation Bar
            TopNavigationCanvas(settingsTopNavigation: settingsTopNavigation)
                .zIndex(1)
            
            /// Library View
            LibraryView()
        }
        .toolbar(.hidden)
        .background(curiPalette(.paper500))
        .sheet(isPresented: $settingsTopNavigation) {
            SettingsSheetView()
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $searchTopNavigation) {
            SearchSheetView()
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    @Previewable @State var settingsTopNavigation: Bool = false
    @Previewable @State var searchTopNavigation: Bool = true
    HomeView(settingsTopNavigation: $settingsTopNavigation, searchTopNavigation: $searchTopNavigation)
}
