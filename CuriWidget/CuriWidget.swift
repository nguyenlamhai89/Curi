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
    @Query var quoteDatabase: [Quote]
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            authorName: "Author Placeholder",
            bookName: "Book Placeholder",
            quoteContent: "Quote Placeholder",
            highlightName: "Highlight Name",
            highlightColor: "blue-300"
        )
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
            return SimpleEntry(
                date: Date(),
                authorName: "Trần Dần",
                bookName: "Thơ mini",
                quoteContent: "Tôi khóc những chân trời không có người bay; Lại khóc những người bay không có chân trời",
                highlightName: "Thơ tình",
                highlightColor: "blue-300"
            )
        }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
            var entries: [SimpleEntry] = []
            let quoteInWidget = quoteDatabase.last

            let currentDate = Date()
            for hourOffset in 0..<5 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                let entry = SimpleEntry(
                    date: entryDate,
                    authorName: quoteInWidget?.quoteAuthor ?? "",
                    bookName: quoteInWidget?.quoteBook ?? "",
                    quoteContent: quoteInWidget?.quoteContent ?? "",
                    highlightName: quoteInWidget?.quoteHighlight.name ?? "",
                    highlightColor: quoteInWidget?.quoteHighlight.primaryBackgroundColor ?? "pink-300"
                )
                entries.append(entry)
            }

            return Timeline(entries: entries, policy: .never)
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
}

struct CuriWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    @Query var quoteDatabase: [Quote]
    var entry: Provider.Entry
    
//    let quoteOfTheDay = DataService()

    var body: some View {
        VStack (spacing: curiSpacing(.sp12)) {
            if quoteDatabase.isEmpty {
                Text("Read a book and highlight your first favorite quote!")
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
                .modelContainer(for: [HighlightPencil.self, Quote.self, Note.self])
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
        highlightColor: "cyan"
    )
}
