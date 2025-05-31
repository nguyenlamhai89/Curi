////
////  CuriAppApp.swift
////  CuriApp
////
////  Created by Hai Lam Nguyen on 20/2/25.
////
//

import SwiftUI
import SwiftData

@main
struct CuriAppApp: App {
    let config = ModelConfiguration(cloudKitDatabase: .private("iCloud.madeby.nham.curiapp"))
    let modelContainer: ModelContainer
    
    init() {
        do {
            self.modelContainer = try ModelContainer(
                for: HighlightPencil.self, Quote.self, Note.self, User.self,
                configurations: config
            )
        } catch {
            fatalError("Cannot create ModelContainer: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeViewManager()
        }
        .modelContainer(modelContainer)
    }
}
