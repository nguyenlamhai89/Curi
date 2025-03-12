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
    
    @State var pageOneIsSelected: Bool = true
    @State var pageTwoIsSelected: Bool = false
    
    var body: some View {
        ZStack {
            /// Top Navigation Bar
            TopNavigationCanvas(settingsTopNavigation: $settingsTopNavigation, searchTopNavigation: $searchTopNavigation, pageOneIsSelected: $pageOneIsSelected, pageTwoIsSelected: $pageTwoIsSelected)
                .zIndex(1)
            
            /// Library View
            
            if pageOneIsSelected {
                LibraryView()
            } else {
                QuoteView()
            }
            
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
