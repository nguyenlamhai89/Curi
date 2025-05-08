//
//  ReadingAnalyticsView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 8/5/25.
//

import SwiftUI
import SwiftData

struct ReadingAnalyticsView: View {
    
    @Query var quoteDatabase: [Quote]
    
    var noteNumber: Int {
        quoteDatabase.filter { $0.quoteNote.hasContent }.count
    }
    
    var connectionNumber: Int {
        quoteDatabase.filter { !($0.connectedQuotes?.isEmpty ?? true) }.count
    }
    
    var body: some View {
        VStack (spacing: curiSpacing(.sp8)) {
            AnalyticsLineTime(analyticsTitle: "Reading Time", analyticsValue: 50)
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
            Text("\(analyticsValue, specifier: "%.f") min")
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

#Preview {
    ReadingAnalyticsView()
}
