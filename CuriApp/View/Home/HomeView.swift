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
    @State var widgetTopNavigation: Bool = false
    @State var viewAllNavigation: Bool = false
    
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
    
    @State var renameViewPrimary: Bool = false
    @State var renameViewSecondary: Bool = false
    
    @State var quoteCardisPresented: Bool = false
    
    var body: some View {
        ZStack {
            /// Top Navigation Bar
            TopNavigationCanvas(settingsTopNavigation: $settingsTopNavigation, widgetTopNavigation: $widgetTopNavigation, pageOneIsSelected: $pageOneIsSelected, pageTwoIsSelected: $pageTwoIsSelected)
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
                                    renameViewPrimary: $renameViewPrimary,
                                    renameViewSecondary: $renameViewSecondary)
                    } else {
                        LibraryErrorView(bookViewModel: bookViewModel)
                    }
                }
            } else {
                QuoteView(bookViewModel: bookViewModel, nameHighlightPrimary: $nameHighlightPrimary,
                          nameHighlightSecondary: $nameHighlightSecondary,
                          placeholderHighlightName: placeholderHighlightName,
                          renameViewPrimary: $renameViewPrimary,
                          renameViewSecondary: $renameViewSecondary, quoteCardIsPresented: $quoteCardisPresented, viewAllNavigation: $viewAllNavigation)            }
        }
        .toolbar(.hidden)
        .background(curiPalette(.paper500))
        .task {
            try? await bookViewModel.fetchBooks()
        }
        .sheet(isPresented: $settingsTopNavigation) {
            SettingsSheetView()
        }
        .sheet(isPresented: $widgetTopNavigation) {
            WidgetIntroducingView()
        }
        .overlay {
            if renameViewPrimary {
                RenameHighlightView(backgroundColor: curiPalette(.blue500),
                                    placeholderHighlightName: placeholderHighlightName,
                                    highlightName: $nameHighlightPrimary,
                                    viewIsPresented: $renameViewPrimary)
            } else if renameViewSecondary {
                RenameHighlightView(backgroundColor: curiPalette(.pink500),
                                    placeholderHighlightName: placeholderHighlightName,
                                    highlightName: $nameHighlightSecondary,
                                    viewIsPresented: $renameViewSecondary)
            }
        }
    }
}

#Preview {
    HomeViewManager()
}
