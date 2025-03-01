//
//  UserSettingsView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 27/2/25.
//

import SwiftUI

struct SettingsSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack (spacing: 0) {
            /// Top Navigation
            HStack {
                Text("Hai Lam Nguyen")
                    .curiTypo(.bkBold16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                
                IconButtonDefault(iconName: "curiDelete") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, curiSpacing(.sp16))
            .padding(.vertical, curiSpacing(.sp20))
            
            Spacer()
            
            /// About Curi
            VStack (spacing: curiSpacing(.sp16)) {
                Image("curiLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
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
            .frame(height: 80)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, curiSpacing(.sp16))
        }
        .background(curiPalette(.paper500))
        
    }
}

#Preview {
    SettingsSheetView()
}
