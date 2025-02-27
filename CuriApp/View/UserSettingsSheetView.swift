//
//  UserSettingsView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 27/2/25.
//

import SwiftUI

struct UserSettingsSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack (spacing: 0) {
            HStack {
                /// iCloud Username
                Text("Hai Lam Nguyen")
                    .curiTypo(.bkBold16)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, curiSpacing(.sp16))
            .padding(.vertical, curiSpacing(.sp20))
            
            Spacer()
            
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
            Button {
                print("Signed Out")
            } label: {
                CTAButtonSecondary(content: "Sign Out")
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, curiSpacing(.sp16))
        }
        .background(curiPalette(.paper500))
    }
}

#Preview {
    UserSettingsSheetView()
}
