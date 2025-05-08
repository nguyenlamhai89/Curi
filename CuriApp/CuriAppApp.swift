//
//  CuriAppApp.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 20/2/25.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct CuriAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            HomeViewManager()
//            AnalyticsView()
        }
        .modelContainer(for: [HighlightPencil.self, Quote.self, Note.self, ReadTime.self])
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("🔥 Configured!")
        return true
    }
}
