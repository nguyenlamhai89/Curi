//
//  HomeView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI

struct HomeViewManager: View {
    @Bindable var bookViewModel = BookViewModel()
    
    // Navigation Value
    @State var settingsTopNavigation: Bool = false
    @State var searchTopNavigation: Bool = false
    
    // Switch Page Value
    @State var pageOneIsSelected: Bool = true
    @State var pageTwoIsSelected: Bool = false
    
    // Banner Value
    var bookNameInBanner: String = "Sonnet"
    var authorNameInBanner: String = "William Shakespeare"
    
    // Quote - Book Value
    @State var nameHighlightPrimary: String = "Discuss Later"
    @State var nameHighlightSecondary: String = "Good Point"
    
    var placeholderHighlightName: String = "Highlight Name"
    
    @State var renameHighlightPrimaryView: Bool = false
    @State var renameHighlightSecondaryView: Bool = false
    
    
    var body: some View {
        ZStack {
            /// Top Navigation Bar
            TopNavigationCanvas(settingsTopNavigation: $settingsTopNavigation, searchTopNavigation: $searchTopNavigation, pageOneIsSelected: $pageOneIsSelected, pageTwoIsSelected: $pageTwoIsSelected)
                .zIndex(1)
            
            /// Main View
            if pageOneIsSelected {
                if bookViewModel.isLoading {
                    SkeletonView(bookViewModel: bookViewModel)
                } else {
                    if bookViewModel.isFetched {
                        LibraryView(bookViewModel: bookViewModel, bookNameInBanner: bookNameInBanner,
                                    authorNameInBanner: authorNameInBanner,
                                    nameHighlightPrimary: $nameHighlightPrimary,
                                    nameHighlightSecondary: $nameHighlightSecondary,
                                    placeholderHighlightName: placeholderHighlightName,
                                    renameHighlightPrimaryView: $renameHighlightPrimaryView,
                                    renameHighlightSecondaryView: $renameHighlightSecondaryView)
                    } else {
                        LibraryErrorView(bookViewModel: bookViewModel)
                    }
                }
            } else {
                QuoteView(nameHighlightPrimary: $nameHighlightPrimary,
                          nameHighlightSecondary: $nameHighlightSecondary,
                          placeholderHighlightName: placeholderHighlightName,
                          renameHighlightPrimaryView: $renameHighlightPrimaryView,
                          renameHighlightSecondaryView: $renameHighlightSecondaryView)
            }
        }
        .toolbar(.hidden)
        .background(curiPalette(.paper500))
        .task {
            try? await bookViewModel.fetchBooks()
        }
        .sheet(isPresented: $settingsTopNavigation) {
            SettingsSheetView()
        }
        .navigationDestination(isPresented: $searchTopNavigation) {
            SearchView()
        }
        .overlay {
            if renameHighlightPrimaryView {
                RenameHighlightView(backgroundColor: curiPalette(.blue500),
                                    placeholderHighlightName: placeholderHighlightName,
                                    highlightName: $nameHighlightPrimary,
                                    viewIsPresented: $renameHighlightPrimaryView)
            }
        }
    }
}

#Preview {
    HomeViewManager()
}
