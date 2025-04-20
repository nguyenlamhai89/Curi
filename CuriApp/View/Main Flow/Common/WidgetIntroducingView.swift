//
//  WidgetIntroducingView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 5/4/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct WidgetIntroducingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let featureBannerGIF: String = "curiWidgetIntroducingGIF.gif"
    
    let featureName: String = "Curi's Widget"
    let featureHeadline: String = "Let words find you"
    let featureDescription: String = "Each day, a gentle reminder — your saved highlight waiting quietly on the Home Screen."
    let featureCTA: String = "Got it"
    
    let stepsWidget: [(image: String, description: String)] = [
        (image: "curiStep1", description: "Tap and hold anywhere on your Home Screen"),
        (image: "curiStep2", description: "Tap Edit in the top left corner, then tap Add Widget"),
        (image: "curiStep3", description: "Search for Curi and tap Add Widget")
    ]
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                ScrollView {
                    VStack (spacing: 0) {
                        // GIF
                        AnimatedImage(name: featureBannerGIF, isAnimating: .constant(true))
                            .resizable()
                            .scaledToFill()
                        
                        // Content
                        VStack (spacing: curiSpacing(.sp32)) {
                            VStack (spacing: curiSpacing(.sp8)) {
                                HStack (spacing: curiSpacing(.sp4)) {
                                    Image("curiWidgetLeft")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24)
                                    Text(featureName)
                                        .curiTypo(.bkRegular14)
                                        .foregroundColor(curiPalette(.blue500))
                                        .padding(.vertical, curiSpacing(.sp2))
                                        .padding(.horizontal, curiSpacing(.sp8))
                                        .background(curiPalette(.blue100))
                                        .cornerRadius(curiRadius(.rd4))
                                    Image("curiWidgetRight")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24)
                                }
                                .frame(maxWidth: .infinity)
                                //                        .background(Color.yellow) // Check section
                                
                                Text(featureHeadline)
                                    .curiTypo(.bkRegular32)
                                    .foregroundStyle(curiPalette(.ink500))
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity)
                                //                        .background(Color.yellow) // Check section
                                Text(featureDescription)
                                    .curiTypo(.sfRegular16)
                                    .foregroundStyle(curiPalette(.ink300))
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity)
                                //                                                    .background(Color.yellow) // Check section
                            }
                            
                            VStack (spacing: curiSpacing(.sp12)) {
                                ForEach(Array(stepsWidget.enumerated()), id: \.offset) { index, step in
                                    ZStack {
                                        HStack (spacing: curiSpacing(.sp16)) {
                                            Image(step.image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 64)
                                                .cornerRadius(curiRadius(.rd8))
                                            Text(step.description)
                                                .curiTypo(.bkRegular14)
                                                .foregroundStyle(curiPalette(.ink500))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(curiSpacing(.sp8))
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(curiRadius(.rd8))
                                    }
                                    
                                    Divider()
                                }
                            }
                            .padding(.horizontal, curiSpacing(.sp16))
                            //                        .background(Color.red) // Check section
                            
                        }
                        .padding(.horizontal, curiSpacing(.sp16))
                        .padding(.bottom, 80)
                        .padding(.vertical, curiSpacing(.sp32))
                        //                .background(Color.blue) // Check section
                    }
                }
                .scrollIndicators(.hidden)
                
                VStack {
                    Spacer()
                    // CTA
                    CTAButtonPrimary(content: featureCTA) {
                        presentationMode.wrappedValue.dismiss()
                        print(featureCTA)
                    }
                    .bottomNavigationSpacing
                }
            }
        })
        .background(curiPalette(.paper500))
        //        .presentationDragIndicator(.visible)
        .interactiveDismissDisabled(true)
    }
}

#Preview {
    @Previewable @State var sheetPresented: Bool = true
    VStack {
        Text("New Feature: Widget")
    }
    .sheet(isPresented: $sheetPresented) {
        WidgetIntroducingView()
    }
}
