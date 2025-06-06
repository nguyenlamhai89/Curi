//
//  ReadingAnalyticsView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 8/5/25.
//

import SwiftUI
import SwiftData

struct ReadingAnalyticsView: View {
    /// SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var quoteDatabase: [Quote]
    @Query var userSettings: [User]
    
    /// Local View
    var minutesNumber: Double {
        userSettings[0].totalReadTime / 60
    }
    var noteNumber: Int {
        quoteDatabase.filter { $0.quoteNote?.hasContent ?? true }.count
    }
    var connectionNumber: Int {
        quoteDatabase.filter { !($0.connectedQuotes?.isEmpty ?? true) }.count
    }
    
    var body: some View {
        VStack (spacing: curiSpacing(.sp8)) {
            AnalyticsLineTime(analyticsTitle: "Total Minutes Read", analyticsValue: minutesNumber)
            AnalyticsLineDefault(analyticsTitle: "Quotes", analyticsValue: quoteDatabase.count)
            AnalyticsLineDefault(analyticsTitle: "Notes", analyticsValue: noteNumber)
            AnalyticsLineDefault(analyticsTitle: "Connections", analyticsValue: connectionNumber)
        }
        .padding(curiSpacing(.sp16))
        .background(curiPalette(.paper300))
        .cornerRadius(curiRadius(.rd8))
    }
    
}

struct AnalyticsLineTime: View {
    let analyticsTitle: String
    let analyticsValue: Double
    
    var body: some View {
        HStack {
            Text(analyticsTitle)
                .foregroundStyle(curiPalette(.ink500))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(analyticsValue == 0 ? "Not started 💭" : "\(analyticsValue, specifier: "%.1f") min")
                .foregroundStyle(curiPalette(.ink300))
        }
        .curiTypo(.bkRegular14)
        .frame(maxWidth: .infinity)
    }
}

struct AnalyticsLineDefault: View {
    let analyticsTitle: String
    let analyticsValue: Int
    
    var body: some View {
        HStack {
            Text(analyticsTitle)
                .foregroundStyle(curiPalette(.ink500))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(analyticsValue)")
                .foregroundStyle(curiPalette(.ink300))
        }
        .curiTypo(.bkRegular14)
        .frame(maxWidth: .infinity)
    }
}
