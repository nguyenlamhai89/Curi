//
//  CuriWidget.swift
//  CuriWidget
//
//  Created by Hai Lam Nguyen on 8/3/25.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: AppIntentTimelineProvider {
    //    let quoteOfTheDay = DataService()
    //    @Query var quoteDatabase: [Quote]
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            authorName: "Author Placeholder",
            bookName: "Book Placeholder",
            quoteContent: "Quote Placeholder",
            highlightName: "Highlight Name",
            highlightColor: "blue-300",
            lineNumber: 1
        )
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        return SimpleEntry(
            date: Date(),
            authorName: "Trần Dần",
            bookName: "Thơ mini",
            quoteContent: "Tôi khóc những chân trời không có người bay; Lại khóc những người bay không có chân trời",
            highlightName: "Thơ tình",
            highlightColor: "blue-300",
            lineNumber: 0
        )
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        
        var entries: [SimpleEntry] = []
        let defaults = UserDefaults(suiteName: "group.madeby.nham.curiapp")
        
//        let currentDate = Date()
//        let startOfToday = Calendar.current.startOfDay(for: currentDate)
//        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: startOfToday)!
        
        let currentDate = Date()
        let startOfMinute = Calendar.current.dateInterval(of: .minute, for: currentDate)?.start ?? currentDate
        let nextMinute = Calendar.current.date(byAdding: .minute, value: 1, to: startOfMinute)!
        
//        let lastUpdate = defaults?.object(forKey: "lastQuoteUpdateDate") as? Date ?? .distantPast
//        let inSameDay = Calendar.current.isDate(startOfToday, inSameDayAs: lastUpdate)
        
        let lastUpdate = defaults?.object(forKey: "lastQuoteUpdateDate") as? Date ?? .distantPast
        let inSameMinute = Calendar.current.compare(startOfMinute, to: lastUpdate, toGranularity: .minute) == .orderedSame
        
        let quoteOnWidget = inSameMinute ? (defaults?.string(forKey: "widgetQuote") ?? "") : ""
        let authorOnWidget = inSameMinute ? (defaults?.string(forKey: "widgetAuthor") ?? "") : ""
        let bookOnWidget = inSameMinute ? (defaults?.string(forKey: "widgetBook") ?? "") : ""
        let highlightNameOnWidget = inSameMinute ? (defaults?.string(forKey: "widgetHighlightName") ?? "") : ""
        let highlightColorOnWidget = inSameMinute ? (defaults?.string(forKey: "widgetHighlightColor") ?? "blue-300") : ""
        let lineNumOnWidget = inSameMinute ? (defaults?.integer(forKey: "lineNumOnWidget") ?? -1) : -2
        defaults?.set(lineNumOnWidget, forKey: "lineNumOnWidget")
        let entry = SimpleEntry(date: currentDate, authorName: authorOnWidget, bookName: bookOnWidget, quoteContent: quoteOnWidget, highlightName: highlightNameOnWidget, highlightColor: highlightColorOnWidget, lineNumber: lineNumOnWidget)
        entries.append(entry)
        
        return Timeline(entries: entries, policy: .after(nextMinute))
        
    }
    
    //    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
    //        // Generate a list containing the contexts this widget is relevant in.
    //    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let authorName: String
    let bookName: String
    let quoteContent: String
    let highlightName: String
    let highlightColor: String
    let lineNumber: Int
}

struct CuriWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: Provider.Entry
    
    var body: some View {
        VStack (spacing: curiSpacing(.sp12)) {
            if entry.lineNumber == -1 {
                Text("Read a book and highlight your first favorite quote!") // Have no quote yet
                    .curiTypo(.sfMedium16)
                    .foregroundStyle(curiPalette(.ink100))
                    .multilineTextAlignment(.center)
            } else if entry.lineNumber == -2 {
//                Text("Line Number Value: \(entry.lineNumber)") // Daily open
                Text("A new quote awaits — open Curi to unlock today’s!") // Daily open
                    .curiTypo(.sfMedium16)
                    .foregroundStyle(curiPalette(.ink100))
                    .multilineTextAlignment(.center)
            } else {
                HStack {
                    VStack(alignment: .leading) {
                        Text(entry.bookName)
                            .foregroundStyle(curiPalette(.ink500))
                        Text(entry.authorName)
                            .foregroundStyle(curiPalette(.ink300))
                    }
                    .curiTypo(.sfMedium12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                    
                    HighlightTag(content: entry.highlightName, color: Color(entry.highlightColor))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\"\(entry.quoteContent)\"")
                    .curiTypo(.bkRegular16)
                    .foregroundStyle(curiPalette(.ink500))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}

struct CuriWidget: Widget {
    let kind: String = "curiWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            CuriWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
                .modelContainer(for: [HighlightPencil.self, Quote.self, Note.self, User.self])
        }
        .configurationDisplayName("Quote of the Day")
        .description("Shuffle from all the quotes you've highlighted in your entire books")
        .supportedFamilies([.systemMedium])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemMedium) {
    CuriWidget()
} timeline: {
    SimpleEntry(
        date: .now,
        authorName: "Trần Dần",
        bookName: "Thơ mini",
        quoteContent: "Tôi khóc những chân trời không có người bay",
        highlightName: "Bầu trời",
        highlightColor: "cyan",
        lineNumber: 0
    )
}
