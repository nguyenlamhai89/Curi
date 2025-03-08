//
//  LogInView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

struct LogInView: View {
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 0) {
                /// Logo and Motto Section
                VStack (spacing: curiSpacing(.sp16)) {
                    Image("curiLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                    Text("Read. Highlight. Repeat.")
                        .curiTypo(.bkRegular32)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, curiSpacing(.sp16))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                /// Button Section
                CTAButtonPrimary(content: "Sign In with Apple", action: {
                    isLoggedIn = true
                })
                .bottomNavigationSpacing
            }
            .navigationDestination(isPresented: $isLoggedIn, destination: {
                HomeViewTemplate()
            })
            .background(curiPalette(.paper500))
        }
    }
}

#Preview {
    LogInView()
}
