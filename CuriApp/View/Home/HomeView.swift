//
//  HomeView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI

struct HomeViewTemplate: View {
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
        }
        .navigationDestination(isPresented: $searchTopNavigation) {
            SearchView()
        }
    }
}

#Preview {
    HomeViewTemplate()
}
