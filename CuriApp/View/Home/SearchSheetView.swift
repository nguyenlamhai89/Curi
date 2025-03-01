//
//  SearchSheetView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI

struct SearchSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                curiPalette(.paper500)
                    .ignoresSafeArea()
                ScrollView {
                    VStack (spacing: curiSpacing(.sp16)) {
                        ForEach(0..<10) { book in
                            QuoteCardNavigation(bookName: "Book \(book)",
                                      authorName: "Author of book \(book)",
                                      quoteContent: "\(book) - Can you not understand that liberty is worth more than just ribbons?",
                                      highlightTagName: "Discuss Later")
                        }
                    }
                }
                .highPriorityGesture(DragGesture())
                .padding(.horizontal, curiSpacing(.sp16))
                .scrollIndicators(.hidden)
                .navigationTitle("All Quotes")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Done")
                                .fontWeight(.semibold)
                                .foregroundStyle(curiPalette(.ink500))
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Search Your Quote")
            }
            
        }
    }
}

#Preview {
    SearchSheetView()
}
