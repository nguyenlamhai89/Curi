//
//  LogInView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

struct LogInView: View {
    var body: some View {
        NavigationView {
            ZStack {
                /// Background
                Rectangle()
                    .fill(curiPalette(.paper500))
                    .ignoresSafeArea()
                
                /// Main
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
//                                    .background(Color.yellow) // Check section
                    
                    /// Button Section
                    NavigationLink {
                        HomeView()
                    } label: {
                        Text("Sign in with Apple")
                            .curiTypo(.sfRegular16)
                            .foregroundStyle(curiPalette(.paper500))
                            .padding(curiSpacing(.sp12))
                            .frame(maxWidth: .infinity)
                            .background(curiPalette(.ink500))
                            .cornerRadius(curiSpacing(.sp20))
                    }
                    .frame(height: 80)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, curiSpacing(.sp16))
                    //                .background(Color.blue) // Check section
                }
            }
        }
    }
}

#Preview {
    LogInView()
}
