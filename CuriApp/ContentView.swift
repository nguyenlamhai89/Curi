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
            VStack (spacing: 20) {
                Text("Are People Stupid?")
                    .curiTypo(.bkBold16)
                VStack (spacing: 8) {
                    Text("        Remember the volcanic ash cloud over Iceland? The subprime disaster? How about mad cow disease? Each new crisis makes us worry until we forget and start worrying about the next one.")
                    Text("        How to protect ourselves from the next financial crisis? Stricter regulations, more and better advisers. How to protect ourselves from the threat of terrorism? Homeland security, full body scanners, further sacrifice of individual freedom. How to counteract exploding costs in health care?")
                }
                    .curiTypo(.bkRegular16)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
