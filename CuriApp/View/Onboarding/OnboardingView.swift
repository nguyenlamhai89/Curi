//
//  LogInView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var bookViewModel: BookViewModel
    
    var action: () -> Void
    
    var body: some View {
        VStack (spacing: 0) {
            // Image
                Image("curiOnboarding")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: .infinity)
                    .clipped()
//                    .background(Color.cyan) // Check section
            
            // Content
            VStack (spacing: curiSpacing(.sp32)) {
                VStack (spacing: curiSpacing(.sp8)) {
                    Text("Some thoughts are too light to lose")
                        .curiTypo(.bkRegular32)
                        .foregroundStyle(curiPalette(.ink500))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    Text("Highlighting in Curi is like catching butterflies — fleeting, precious, and yours to keep. Your highlights follow you, no sign-in needed.")
                        .curiTypo(.sfRegular16)
                        .foregroundStyle(curiPalette(.ink300))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, curiSpacing(.sp16))
            .padding(.vertical, curiSpacing(.sp32))
//            .background(Color.blue)  // Check section
            
            CTAButtonPrimary(bookViewModel: bookViewModel, content: "Start reading") {
                presentationMode.wrappedValue.dismiss()
                action()
            }
            .bottomNavigationSpacing
        }
        .background(curiPalette(.paper500))
        .interactiveDismissDisabled(true)
//        .presentationDragIndicator(.visible)
    }
}

#Preview {
    @Previewable @StateObject var bookViewModel = BookViewModel()
    Text("Sample")
        .sheet(isPresented: .constant(true)) {
            OnboardingView(bookViewModel: bookViewModel) {
                print("Welcome Onboard")
            }
        }
}


//struct LogInView: View {
//    @State var isLoggedIn: Bool = false
//
//    var body: some View {
//        NavigationStack {
//            VStack (spacing: 0) {
//                /// Logo and Motto Section
//                VStack (spacing: curiSpacing(.sp16)) {
//                    Image("curiLogo")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 120)
//                    Text("Read. Highlight. Repeat.")
//                        .curiTypo(.bkRegular32)
//                        .multilineTextAlignment(.center)
//                }
//                .padding(.horizontal, curiSpacing(.sp16))
//                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//
//                /// Button Section
//                CTAButtonPrimary(content: "Sign In with Apple", action: {
//                    isLoggedIn = true
//                })
//                .bottomNavigationSpacing
////                SignInWithAppleButtonView()
////                    .bottomNavigationSpacing
//            }
//            .navigationDestination(isPresented: $isLoggedIn, destination: {
//                HomeViewManager()
//            })
//            .background(curiPalette(.paper500))
//        }
//    }
//}
//
//#Preview {
//    LogInView()
//}
