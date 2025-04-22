//
//  UserSettingsView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 27/2/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct SettingsSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let curiLogoGIF: String = "curiLogoGIF.gif"
    
    var body: some View {
        VStack (spacing: 0) {
            /// Top Navigation
            HStack {
                Text("Hai Lam Nguyen")
                    .curiTypo(.bkBold16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                
                IconButton(iconName: "curiDelete", hasNote: false) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, curiSpacing(.sp16))
            .padding(.vertical, curiSpacing(.sp20))
            
            Spacer()
            
            /// About Curi
            VStack (spacing: curiSpacing(.sp16)) {
//                Image("curiLogo")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 24)
                AnimatedImage(name: curiLogoGIF, isAnimating: .constant(true))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                
                VStack (spacing: curiSpacing(.sp8)) {
                    Text("Curi transforms your reading experience into something more memorable and enjoyable.")
                    Text("Last synced: 3 min")
                }
                .curiTypo(.bkRegular14)
                .foregroundStyle(curiPalette(.ink500))
                .multilineTextAlignment(.center)
            }
            .padding(.horizontal, curiSpacing(.sp16))
            .padding(.vertical, curiSpacing(.sp16))
            
            /// Button Section
            CTAButtonSecondary(content: "Sign Out", action: {
                presentationMode.wrappedValue.dismiss()
                print("Signed Out")
            })
            .bottomNavigationSpacing
        }
        .background(curiPalette(.paper500))
        .presentationDetents([.medium])
//        .presentationDragIndicator(.visible)
        .interactiveDismissDisabled(true)
    }
}

#Preview {
    SettingsSheetView()
}
