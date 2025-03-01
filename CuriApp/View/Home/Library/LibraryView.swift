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
                /// Banner
                HStack (alignment: .bottom) {
                    VStack (alignment: .leading, spacing: 0) {
                        Text("Sonnet")
                            .curiTypo(.sfMedium32)
                            .lineLimit(1)
                        Text("William Shakespeare")
                            .curiTypo(.sfMedium16)
                            .lineLimit(1)
                    }
                    .foregroundStyle(curiPalette(.paper500))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Button {
                        print("Go to book")
                    } label: {
                        TextButtonFilled(content: "Read Now")
                    }
                }
                .frame(height: 200, alignment: .bottomLeading)
                .frame(maxWidth: .infinity)
                .padding(curiSpacing(.sp16))
                .background(
                    Image("curiBannerSample")
                        .resizable()
                        .scaledToFill()
                )
                .cornerRadius(curiRadius(.rd4))
                
                /// Library
                VStack (alignment: .leading, spacing: curiSpacing(.sp8)) {
                    Text("For You")
                        .curiTypo(.sfMedium14)
                        .foregroundStyle(curiPalette(.ink300))
                    
                    VStack {
                        ForEach(0..<10) { bookNum in
                            NavigationLink {
                                Text("Book \(bookNum)")
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
