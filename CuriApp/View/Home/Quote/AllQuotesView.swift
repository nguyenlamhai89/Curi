import SwiftUI
import SwiftData

//struct IdentifiableHighlight: Identifiable {
//    var id = UUID()
//    var book: String
//    var author: String
//    var lines: String
//}

struct AllQuotesView: View {
    @State var searchAvailableQuote: String = ""
    
    @Bindable var bookViewModel: BookViewModel
    @Query var quoteDatabase: [Quote]
    @State private var itemSelected: Quote?
    
    var emptyHeadline: String = "No quotes yet, but that’s okay,"
    var emptyParagraph: String = "Start with a book, and mark your way!"
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    ScrollView {
                        VStack (spacing: curiSpacing(.sp16)) {
                            ForEach(quoteDatabase) { quote in
                                QuoteCard(
                                    bookName: quote.quoteBook,
                                    authorName: quote.quoteAuthor,
                                    quoteContent: "\(quote.quoteContent)",
                                    highlightTagName: "Discuss Later",
                                    action: {
//                                        self.itemSelected = IdentifiableHighlight(book: quote.quoteBook, author: quote.quoteAuthor, lines: quote.quoteContent)
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
//            QuoteNoteSheetView(
//                bookViewModel: bookViewModel,
//                quote: item.lines,
//                author: item.author,
//                book: item.book
//            )
            QuoteNoteSheetView(bookViewModel: bookViewModel, quote: item)
        }
    }
}

#Preview {
    @Previewable @Bindable var bookViewModel = BookViewModel()
    AllQuotesView(bookViewModel: bookViewModel)
}
