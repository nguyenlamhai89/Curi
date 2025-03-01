//
//  HomeView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI

struct HomeView: View {
    @State var settingsTopNavigation: Bool = false
    @State var searchTopNavigation: Bool = false
    
    var body: some View {
        ZStack {
            /// Top Navigation Bar
            TopNavigationCanvas(settingsTopNavigation: $settingsTopNavigation, searchTopNavigation: $searchTopNavigation)
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
    HomeView()
}
