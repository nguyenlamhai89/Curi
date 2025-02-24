//
//  ContentView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 20/2/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            VStack {
                Text("Remember the volcanic ash cloud over Iceland? The subprime disaster? How about mad cow disease? Each new crisis makes us worry until we forget and start worrying about the next one.")
//                Text("Hello, world!")
            }
            .curiTypography(.bkRegular16)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
