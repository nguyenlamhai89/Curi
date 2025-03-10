//
//  CuriWidget.swift
//  CuriWidget
//
//  Created by Hai Lam Nguyen on 8/3/25.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    let quoteOfTheDay = DataService()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), quote: quoteOfTheDay.fetchSampleQuote())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), quote: quoteOfTheDay.fetchSampleQuote())
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, quote: quoteOfTheDay.fetchSampleQuote())
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let quote: String
}

struct CuriWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    let quoteOfTheDay = DataService()

    var body: some View {
        VStack (spacing: 16) {
            HStack {
                VStack (alignment: .leading) {
                    Text("Animal Farm")
                    Text("George Orwell")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                
                Text("Discuss Later")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.blue)
                    .cornerRadius(4)
                    .foregroundStyle(Color.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 12))
            
            Text("“\(quoteOfTheDay.fetchSampleQuote())”")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .font(.system(size: 16, weight: .medium))
        }
    }
}

struct CuriWidget: Widget {
    let kind: String = "curiWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            CuriWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
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
    SimpleEntry(date: .now, quote: "Hihi")
    SimpleEntry(date: .now, quote: "Alo tôi đâyyy test tí nào")
}
