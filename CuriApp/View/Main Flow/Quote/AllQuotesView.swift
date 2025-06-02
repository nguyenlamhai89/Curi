import SwiftUI
import SwiftData

struct AllQuotesView: View {
    /// SwiftData
    @Query(sort: \Quote.quoteAddedDate, order: .reverse) var quoteDatabase: [Quote]
    
    /// Local View
    @ObservedObject var bookViewModel: BookViewModel
    @State var itemSelected: Quote?
    @State var showAddQuoteSheet: Bool = false
    @State var searchAvailableQuote: String = ""
    @State var bookNavigated: Bool = false
    var filteredQuoteContent: [Quote] {
        guard !searchAvailableQuote.isEmpty else {
            return quoteDatabase
        }
        return quoteDatabase.filter {
            $0.quoteContent.localizedCaseInsensitiveContains(searchAvailableQuote)
        }
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    ScrollView {
                        VStack (spacing: curiSpacing(.sp16)) {
                            ForEach(filteredQuoteContent) { quote in
                                QuoteCard(
                                    bookViewModel: bookViewModel,
                                    quoteBook: quote.quoteBook,
                                    quoteAuthor: quote.quoteAuthor,
                                    quoteContent: "\(quote.quoteContent)",
                                    quoteHighlightName: quote.quoteHighlight?.name ?? "",
                                    quoteHighlightColor: quote.quoteHighlight?.primaryBackgroundColor ?? "",
                                    action: {
                                        showAddQuoteSheet.toggle()
                                        itemSelected = quote
                                        print("HAINL self.itemSelected \(String(describing: itemSelected))")
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
        .sheet(isPresented: $showAddQuoteSheet, content: {
            QuoteNoteSheetView(bookViewModel: bookViewModel, bookNavigated: $bookNavigated, quote: itemSelected ?? Quote(quoteID: UUID(), quoteLineNum: 0, quoteAddedDate: Date(), quoteBook: "", quoteAuthor: "", quoteContent: "", quoteHighlight: HighlightPencil(name: "", primaryTextColor: "", primaryBackgroundColor: "b", secondaryTextColor: "", secondaryBackgroundColor: "", highlightedTextColor: "", defaultHighlightedBackgroundColor: "", selectedHighlightedBackgroundColor: ""), isConnected: false, quoteNote: Note(noteContent: "")))
        })
        .navigationDestination(isPresented: $bookNavigated) {
            if let book = bookViewModel.bookDatabase.first(where: { $0.title == itemSelected?.quoteBook }) {
                BookView(
                    bookViewModel: bookViewModel,
                    bookLinesOriginal: book.lines,
                    bookID: book.id,
                    bookTitle: book.title,
                    bookAuthor: book.author
                )
            } else {
                Text("Book not found")
            }
        }
    }
}
