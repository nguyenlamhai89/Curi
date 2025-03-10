//
//  DataService.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 10/3/25.
//

import Foundation
import SwiftUI

struct DataService {
    @AppStorage("sampleQuote", store: UserDefaults(suiteName: "group.madebynham.curi")) var sampleQuote: String = "Can you not understand that liberty is worth more than just ribbons?"
    
    func fetchSampleQuote() -> String {
        return sampleQuote
    }
}
