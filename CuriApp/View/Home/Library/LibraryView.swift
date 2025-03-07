//
//  HomeView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI



struct LibraryView: View {
    @State var books = ["Hi", "Bar", "Mot"]
    @State var authors = ["Ben", "Will", "Coulson"]
    
    var body: some View {
        ScrollView {
            VStack (spacing: curiSpacing(.sp20)) {
                Banner()
                
                /// Book List
                VStack (alignment: .leading, spacing: curiSpacing(.sp8)) {
                    Text("For You")
                        .curiTypo(.sfMedium14)
                        .foregroundStyle(curiPalette(.ink300))
                    
                    VStack {
                        ForEach(Array(zip(books, authors)), id: \.0) { book, author in
                            NavigationLink {
                                BookView(bookName: "\(book)")
                            } label: {
                                BookAuthorCard(bookName: "\(book)", authorName: "\(author)")
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

            }
            .padding(.top, 80)
            .padding(.horizontal, curiSpacing(.sp16))
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    LibraryView()
}
