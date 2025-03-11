//
//  SampleTabView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 11/3/25.
//

import SwiftUI

struct SampleTabView: View {
    @State private var selectedTabIndex: Int = 0
    var body: some View {
        TabView(selection: $selectedTabIndex, content: {
            Rectangle()
                .fill(Color.red)
                .tag(0)
            Rectangle()
                .fill(Color.green)
                .tag(1)
            Rectangle()
                .fill(Color.blue)
                .tag(2)
        })
        
        HStack {
            Button {
                selectedTabIndex -= 1
            } label: {
                Text("Previous Page")
            }
            Spacer()
            Button {
                selectedTabIndex += 1
            } label: {
                Text("Next Page")
            }
        }

    }
}

#Preview {
    SampleTabView()
}
