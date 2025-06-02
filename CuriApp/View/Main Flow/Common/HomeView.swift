//
//  HomeView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI
import SwiftData

struct HomeViewManager: View {
    /// SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var pencilDatabase: [HighlightPencil]
    @Query var userSettings: [User]
    @Query(sort: \Quote.quoteAddedDate, order: .reverse) var quoteDatabase: [Quote]
    
    /// Local View
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.presentationMode) var presentationMode
    @StateObject var bookViewModel = BookViewModel()
    @State var settingsTopNavigation: Bool = false
    @State var widgetTopNavigation: Bool = false
    @State var isPresentedRenameView: Bool = false
    @State var libraryViewIsPresented: Bool = true
    @State var quoteViewIsPresented: Bool = false
    
    var quoteOnPaper: Quote {
        if let first = quoteDatabase.first {
            return first
        } else {
//            return Quote()
            return Quote(quoteID: UUID(), quoteLineNum: 0, quoteAddedDate: Date(), quoteBook: "", quoteAuthor: "", quoteContent: "", quoteHighlight: HighlightPencil(name: "", primaryTextColor: "", primaryBackgroundColor: "", secondaryTextColor: "", secondaryBackgroundColor: "", highlightedTextColor: "", defaultHighlightedBackgroundColor: "", selectedHighlightedBackgroundColor: ""), isConnected: false, quoteNote: Note(noteContent: ""))
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
                            LibraryView(bookViewModel: bookViewModel)
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
            .sheet(isPresented: $bookViewModel.appIntroducingSheet, content: {
                OnboardingView(bookViewModel: bookViewModel) {
                    bookViewModel.firstTimeInApp = false
                }
            })
            .onAppear {
                bookViewModel.checkFirstTimeInApp()
                bookViewModel.getUserSettings(userSettings: userSettings, modelContext: modelContext)
                bookViewModel.getHighlightPencils(pencilDatabase: pencilDatabase, modelContext: modelContext)
                
                print("[\(pencilDatabase.count)] Pencils - \(pencilDatabase)")
                print(bookViewModel.selectedPen?.name ?? "❌ No Pen Selected")
                
                if let thisUser = userSettings.first {
                    thisUser.quoteDatabase = quoteDatabase
                    thisUser.pencilDatabase = pencilDatabase
                    try? modelContext.save()
                    print("Quote Database: \(String(describing: thisUser.quoteDatabase))")
                    print("Pencil Database: \(String(describing: thisUser.pencilDatabase))")
                } else {
                    print("-- Nil!")
                }
                
                bookViewModel.getiCloudStatus()
            }
            .overlay {
                if isPresentedRenameView {
                    let bindingToName = Binding(
                        get: { quoteOnPaper.quoteHighlight?.name ?? "" },
                        set: { newValue in
                            quoteOnPaper.quoteHighlight?.name = newValue
                            try? modelContext.save()
                        }
                    )
                    
                    RenameHighlightView(
                        highlightName: bindingToName, backgroundColor: Color(quoteOnPaper.quoteHighlight?.primaryBackgroundColor ?? "ink-500")
                    ) {
                        bookViewModel.quoteChangedTrigger = UUID()
                        bookViewModel.lastSyncedTime = Date()
                        isPresentedRenameView.toggle()
                    }
                }
            }
            .onChange(of: bookViewModel.quoteChangedTrigger) {
                bookViewModel.updateQOTD(quoteDatabase: quoteDatabase)
            }
            .onChange(of: scenePhase) { oldPhase, newPhase in
                if newPhase == .active {
                    bookViewModel.checkQOTD(quoteDatabase: quoteDatabase)
                    print("++ QOTD Checked ++")
                    
                    if let thisUser = userSettings.first {
                        thisUser.quoteDatabase = quoteDatabase
                        thisUser.pencilDatabase = pencilDatabase
                        try? modelContext.save()
                        print("Quote Database: \(String(describing: thisUser.quoteDatabase))")
                        print("Pencil Database: \(String(describing: thisUser.pencilDatabase))")
                    } else {
                        print("-- Nil!")
                    }
                }
                print("🦧 User ID: \(bookViewModel.userID)")
            }
        }
    }
}

#Preview {
    HomeViewManager()
}
