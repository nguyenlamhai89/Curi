//
//  Banner.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI

struct Banner: View {
    @State var bookNavigate: Bool = false
    var body: some View {
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
            
            TextButtonFilled(content: "Read Now", action: {
                bookNavigate.toggle()
                print("Go to book")
            })
            .navigationDestination(isPresented: $bookNavigate) {
                BookView(bookName: "Sonnet")
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
    }
}

#Preview {
    Banner()
        .padding(16)
}
