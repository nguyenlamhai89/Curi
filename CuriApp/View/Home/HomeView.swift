//
//  HomeView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI
import SwiftData

struct HomeViewManager: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var bookViewModel = BookViewModel()
    @Query var pencilDatabase: [HighlightPencil]
        
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
//    @State var nameHighlightPrimary: String = "Discuss Later"
//    @State var nameHighlightSecondary: String = "Good Point"
    
    var placeholderHighlightName: String = "Your Highlight Name"
    
//    @State var renameViewPrimary: Bool = false
//    @State var renameViewSecondary: Bool = false
    
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
                        LibraryView(bookViewModel: bookViewModel, bookNameInBanner: bookNameInBanner, authorNameInBanner: authorNameInBanner, placeholderHighlightName: placeholderHighlightName)
                    } else {
                        LibraryErrorView(bookViewModel: bookViewModel)
                    }
                }
            } else {
                QuoteView(bookViewModel: bookViewModel, placeholderHighlightName: placeholderHighlightName, quoteCardIsPresented: $quoteCardisPresented, viewAllNavigation: $viewAllNavigation)
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
        .sheet(isPresented: $widgetTopNavigation) {
            WidgetIntroducingView()
        }
        .onAppear {
            if pencilDatabase.isEmpty {
                var pencil1 = HighlightPencil(
                    name: "Discuss Later",
                    primaryTextColor: "paper-500",
                    primaryBackgroundColor: "blue-300",
                    secondaryTextColor: "blue-500",
                    secondaryBackgroundColor: "blue-100",
                    highlightedTextColor: "blue-500",
                    defaultHighlightedBackgroundColor: "blue-100",
                    selectedHighlightedBackgroundColor: "blue-200"
                )
                var pencil2 = HighlightPencil(
                    name: "Good Point",
                    primaryTextColor: "paper-500",
                    primaryBackgroundColor: "pink-300",
                    secondaryTextColor: "pink-500",
                    secondaryBackgroundColor: "pink-100",
                    highlightedTextColor: "pink-500",
                    defaultHighlightedBackgroundColor: "pink-100",
                    selectedHighlightedBackgroundColor: "pink-200"
                )
                modelContext.insert(pencil1)
                modelContext.insert(pencil2)
                print("🖍️ Available Highlight Pencils: \(pencilDatabase.count)")
                print("--- \(pencilDatabase)")
            }
        }
//        .overlay {
//            if renameViewPrimary {
//                RenameHighlightView(backgroundColor: curiPalette(.blue500),
//                                    placeholderHighlightName: placeholderHighlightName,
//                                    highlightName: $nameHighlightPrimary,
//                                    viewIsPresented: $renameViewPrimary)
//            } else if renameViewSecondary {
//                RenameHighlightView(backgroundColor: curiPalette(.pink500),
//                                    placeholderHighlightName: placeholderHighlightName,
//                                    highlightName: $nameHighlightSecondary,
//                                    viewIsPresented: $renameViewSecondary)
//            }
//        }
    }
}

#Preview {
    HomeViewManager()
}
