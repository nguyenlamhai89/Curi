import SwiftUI
import SwiftData


struct AllQuotesView: View {
    @State var searchAvailableQuote: String = ""
    
    @Bindable var bookViewModel: BookViewModel
//    @Query var quoteDatabase: [Quote]
    @Query(sort: \Quote.quoteAddedDate, order: .reverse) var quoteDatabase: [Quote]
    @State private var itemSelected: Quote?
    
    var emptyHeadline: String = "No quotes yet, but that’s okay,"
    var emptyParagraph: String = "Start with a book, and mark your way!"
    
//    var nameHighlightPrimary: String
//    var nameHighlightSecondary: String
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    ScrollView {
                        VStack (spacing: curiSpacing(.sp16)) {
                            ForEach(quoteDatabase) { quote in
                                QuoteCard(
                                    quoteBook: quote.quoteBook,
                                    quoteAuthor: quote.quoteAuthor,
                                    quoteContent: "\(quote.quoteContent)",
                                    quoteHighlightName: quote.quoteHighlight.name,
                                    quoteHighlightColor: quote.quoteHighlight.primaryBackgroundColor,
                                    action: {
                                        self.itemSelected = quote
                                        print("HAINL self.itemSelected \(String(describing: self.itemSelected))")
                                    }
                                )
                            }
                        }
                    }
                }
                .navigationTitle("All Quotes (\(quoteDatabase.count))")
                .navigationBarTitleDisplayMode(.inline)
                .padding(.horizontal, curiSpacing(.sp16))
                .frame(maxWidth: .infinity)
                .scrollIndicators(.hidden)
                .searchable(text: $searchAvailableQuote, placement:.navigationBarDrawer(displayMode: .always), prompt: "Search Your Quote")
            }
            .background(curiPalette(.paper500))
        }
        .sheet(item: $itemSelected) { item in
            QuoteNoteSheetView(bookViewModel: bookViewModel, quote: item)
        }
    }
}

//#Preview {
//    @Previewable @Bindable var bookViewModel = BookViewModel()
//    AllQuotesView(bookViewModel: bookViewModel, nameHighlightPrimary: "Hi", nameHighlightSecondary: "Haha")
//}
