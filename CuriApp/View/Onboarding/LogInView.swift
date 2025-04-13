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
//                SignInWithAppleButtonView()
//                    .bottomNavigationSpacing
            }
            .navigationDestination(isPresented: $isLoggedIn, destination: {
                HomeViewManager()
            })
            .background(curiPalette(.paper500))
        }
    }
}

import AuthenticationServices

struct SignInWithAppleButtonView: View {
    var body: some View {
        SignInWithAppleButton(.signIn, onRequest: { request in
            request.requestedScopes = [.fullName, .email]
        }, onCompletion: { result in
            switch result {
            case .success(let authResults):
                // Use authResults.credential.user as user identifier
                print("✅ Apple Sign-In Success: \(authResults)")
            case .failure(let error):
                print("❌ Apple Sign-In Error: \(error.localizedDescription)")
            }
        })
        .signInWithAppleButtonStyle(.black)
        .frame(height: 44)
    }
}

#Preview {
    LogInView()
}
