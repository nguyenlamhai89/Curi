//
//  CuriAppApp.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 20/2/25.
//

import SwiftUI
import SwiftData

@main
struct CuriAppApp: App {
    var body: some Scene {
        WindowGroup {
            LogInView()
        }
        .modelContainer(for: [Highlight.self, Note.self])
    }
}
