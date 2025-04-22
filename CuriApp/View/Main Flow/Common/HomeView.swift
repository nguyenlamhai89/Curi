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
    @State var bookViewModel = BookViewModel()
    @Query var pencilDatabase: [HighlightPencil] = []
    @Query var quoteDatabase: [Quote]
        
    // Navigation Value
    @State var settingsTopNavigation: Bool = false
    @State var widgetTopNavigation: Bool = false
    @State var isPresentedRenameView: Bool = false
    
    // Switch Tab Value
    @State var libraryViewIsPresented: Bool = true
    @State var quoteViewIsPresented: Bool = false
    
    // Banner Value
    var bookNameInBanner: String = "Sonnet"
    var authorNameInBanner: String = "William Shakespeare"
    
    var quoteOnPaper: Quote {
        if let first = quoteDatabase.first {
            return first
        } else {
            return Quote(bookID: UUID(), quoteBook: "", quoteAuthor: "", quoteContent: "", quoteHighlight: HighlightPencil(name: "", primaryTextColor: "", primaryBackgroundColor: "b", secondaryTextColor: "", secondaryBackgroundColor: "", highlightedTextColor: "", defaultHighlightedBackgroundColor: "", selectedHighlightedBackgroundColor: ""), quoteNote: Note())
        }
    }
    
    var body: some View {
        ZStack {
            
            /// Main View
            if libraryViewIsPresented {
                if bookViewModel.isLoading {
                    LibrarySkeletonView(bookViewModel: bookViewModel)
                } else {
                    if bookViewModel.isFetched {
                        LibraryView(bookViewModel: bookViewModel, bookNameInBanner: bookNameInBanner, authorNameInBanner: authorNameInBanner)
                    } else {
                        LibraryErrorView(bookViewModel: bookViewModel)
                    }
                }
            } else {
                QuoteView(bookViewModel: bookViewModel, isPresentedRenameView: $isPresentedRenameView)
            }
            
            /// Top Navigation Bar
            TopNavigationUniversal(settingsTopNavigation: $settingsTopNavigation, widgetTopNavigation: $widgetTopNavigation, isOpenedTabOne: $libraryViewIsPresented, isOpenedTabTwo: $quoteViewIsPresented)
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
            let pencilLibrary: [HighlightPencil] = [
                HighlightPencil(
                    name: "Discuss Later",
                    primaryTextColor: "paper-500",
                    primaryBackgroundColor: "blue-300",
                    secondaryTextColor: "blue-500",
                    secondaryBackgroundColor: "blue-100",
                    highlightedTextColor: "blue-500",
                    defaultHighlightedBackgroundColor: "blue-100",
                    selectedHighlightedBackgroundColor: "blue-200"
                ),
                HighlightPencil(
                    name: "Good Point",
                    primaryTextColor: "paper-500",
                    primaryBackgroundColor: "pink-300",
                    secondaryTextColor: "pink-500",
                    secondaryBackgroundColor: "pink-100",
                    highlightedTextColor: "pink-500",
                    defaultHighlightedBackgroundColor: "pink-100",
                    selectedHighlightedBackgroundColor: "pink-200"
                )
            ]
            
            if pencilDatabase.isEmpty {
                for insertPencil in pencilLibrary {
                    modelContext.insert(insertPencil)
                }
                print("🖍️ Available Highlight Pencils: \(pencilDatabase.count)")
                print("--- \(pencilDatabase)")
            } else {
                for index in pencilDatabase.indices {
                    let pencilOld = pencilDatabase[index]
                    let pencilNew = pencilLibrary[index]
                    
                    pencilOld.name = pencilNew.name
                    pencilOld.primaryTextColor = pencilNew.primaryTextColor
                    pencilOld.primaryBackgroundColor = pencilNew.primaryBackgroundColor
                    pencilOld.secondaryTextColor = pencilNew.secondaryTextColor
                    pencilOld.secondaryBackgroundColor = pencilNew.secondaryBackgroundColor
                    pencilOld.highlightedTextColor = pencilNew.highlightedTextColor
                    pencilOld.defaultHighlightedBackgroundColor = pencilNew.defaultHighlightedBackgroundColor
                    pencilOld.selectedHighlightedBackgroundColor = pencilNew.selectedHighlightedBackgroundColor
                }
                try? modelContext.save()
            }
        }
        .overlay {
            if isPresentedRenameView {
                let bindingToName = Binding(
                    get: { quoteOnPaper.quoteHighlight.name },
                    set: { newValue in
                        quoteOnPaper.quoteHighlight.name = newValue
                        try? modelContext.save()
                    }
                )

                RenameHighlightView(
                    highlightName: bindingToName, backgroundColor: Color(quoteOnPaper.quoteHighlight.primaryBackgroundColor)
                ) {
                    isPresentedRenameView.toggle()
                }
            }
        }

    }
}

#Preview {
    HomeViewManager()
}
