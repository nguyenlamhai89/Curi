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
            Text("Hello")
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
                .tint(curiPalette(.ink500))
        }
        .background(curiPalette(.paper500))
    }
}

#Preview {
    SearchSheetView()
}
