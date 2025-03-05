//
//  HomeView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

struct LibraryView: View {
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
                        ForEach(0..<10) { bookNum in
                            NavigationLink {
                                BookView()
                            } label: {
                                BookAuthorCard(bookName: "\(bookNum)", authorName: "\(bookNum)")
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
