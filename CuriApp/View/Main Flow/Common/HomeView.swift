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
    @Environment(\.presentationMode) var presentationMode
    @StateObject var bookViewModel = BookViewModel()
    @Query var pencilDatabase: [HighlightPencil] = []
//    @Query var quoteDatabase: [Quote]
    @Query(sort: \Quote.quoteAddedDate, order: .reverse) var quoteDatabase: [Quote]
        
    // Navigation Value
    @State var settingsTopNavigation: Bool = false
    @State var widgetTopNavigation: Bool = false
    @State var isPresentedRenameView: Bool = false
    
    // Switch Tab Value
    @State var libraryViewIsPresented: Bool = true
    @State var quoteViewIsPresented: Bool = false
    @State var appIntroducingSheet: Bool = false
    
    // Banner Value
    var bookNameInBanner: String = "Sonnet"
    var authorNameInBanner: String = "William Shakespeare"
    
    var quoteOnPaper: Quote {
        if let first = quoteDatabase.first {
            return first
        } else {
            return Quote(bookID: UUID(), quoteID: UUID(), quoteLineNum: 0, quoteBook: "", quoteAuthor: "", quoteContent: "", quoteHighlight: HighlightPencil(name: "", primaryTextColor: "", primaryBackgroundColor: "b", secondaryTextColor: "", secondaryBackgroundColor: "", highlightedTextColor: "", defaultHighlightedBackgroundColor: "", selectedHighlightedBackgroundColor: ""), isConnected: false)
        }
    }
    
    var body: some View {
        NavigationStack {
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
                TopNavigationUniversal(bookViewModel: bookViewModel, settingsTopNavigation: $settingsTopNavigation, widgetTopNavigation: $widgetTopNavigation, isOpenedTabOne: $libraryViewIsPresented, isOpenedTabTwo: $quoteViewIsPresented)
            }
            .toolbar(.hidden)
            .background(curiPalette(.paper500))
            .task {
                try? await bookViewModel.fetchBooks()
            }
            .sheet(isPresented: $settingsTopNavigation) {
                SettingsSheetView(bookViewModel: bookViewModel)
            }
            .sheet(isPresented: $widgetTopNavigation) {
                NewFeatureIntroducingView(
                    bookViewModel: bookViewModel, featureBannerGIF: "curiWidgetIntroducingGIF.gif",
                    featureIconLeft: "curiWidgetLeft",
                    featureIconRight: "curiWidgetRight",
                    featureName: "Curi's Widget",
                    featureHeadline: "Let words find you",
                    featureDescription: "Each day, a gentle reminder — your saved highlight waiting quietly on the Home Screen.",
                    featureCTA: "Got it",
                    stepsWidget: [("curiWidgetStep1", "Tap and hold anywhere on your Home Screen"), ("curiWidgetStep2", "Tap Edit in the top left corner, then tap Add Widget"), ("curiWidgetStep3", "Search for Curi and tap Add Widget")]
                )
            }
            .sheet(isPresented: $appIntroducingSheet, content: {
                OnboardingView(bookViewModel: bookViewModel) {
                    bookViewModel.firstTimeInApp = false
                }
            })
            .onAppear {
                if !bookViewModel.firstTimeInApp {
                    return
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        appIntroducingSheet = true
                    }
                }
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
                } else {
                    for index in pencilDatabase.indices {
                        let pencilOld = pencilDatabase[index]
                        let pencilNew = pencilLibrary[index]
                        
                        //                    pencilOld.name = pencilNew.name
                        pencilOld.primaryTextColor = pencilNew.primaryTextColor
                        pencilOld.primaryBackgroundColor = pencilNew.primaryBackgroundColor
                        pencilOld.secondaryTextColor = pencilNew.secondaryTextColor
                        pencilOld.secondaryBackgroundColor = pencilNew.secondaryBackgroundColor
                        pencilOld.highlightedTextColor = pencilNew.highlightedTextColor
                        pencilOld.defaultHighlightedBackgroundColor = pencilNew.defaultHighlightedBackgroundColor
                        pencilOld.selectedHighlightedBackgroundColor = pencilNew.selectedHighlightedBackgroundColor
                    }
                }
                try? modelContext.save()
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
}

#Preview {
    HomeViewManager()
}
