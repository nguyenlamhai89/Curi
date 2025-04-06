//
//  WidgetIntroducingView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 5/4/25.
//

import SwiftUI

struct WidgetIntroducingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let featureBanner: String = "curiBannerSample"
    
    let featureName: String = "Widget"
    let featureHeadline: String = "Let words find you"
    let featureDescription: String = "Each day, a gentle reminder — your saved highlight waiting quietly on the Home Screen."
    let featureCTA: String = "Got it"
    
    let stepsWidget: [(image: String, description: String)] = [
        (image: "curiStep1", description: "Tap and hold anywhere on your phone's home screen"),
        (image: "curiStep2", description: "Tap the + button in the top left corner"),
        (image: "curiStep3", description: "Search for Curi, then tap Add Widget.")
    ]
    
    var body: some View {
        GeometryReader(content: { geomtry in
            ZStack {
                ScrollView {
                    VStack (spacing: 0) {
                        // GIF
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: geomtry.size.height * 0.4)
                            .foregroundStyle(Color.clear)
                            .background(
                                Image(featureBanner)
                                    .resizable()
                                    .scaledToFill()
                            )
                        
                        // Content
                        VStack (spacing: curiSpacing(.sp32)) {
                            VStack (spacing: curiSpacing(.sp8)) {
                                Text(featureName)
                                    .curiTypo(.bkRegular14)
                                    .foregroundColor(curiPalette(.blue500))
                                    .padding(.vertical, curiSpacing(.sp2))
                                    .padding(.horizontal, curiSpacing(.sp8))
                                    .background(curiPalette(.blue100))
                                    .cornerRadius(curiRadius(.rd4))
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

    //            VStack {
    //                HStack {
    //                    Spacer()
    //                    IconButtonDefault(iconName: "curiDelete") {
    //                        presentationMode.wrappedValue.dismiss()
    //                    }
    //                }
    //                .frame(maxWidth: .infinity)
    //                .padding(.horizontal, curiSpacing(.sp16))
    //                .padding(.vertical, curiSpacing(.sp20))
    //
    //                Spacer()
    //            }
            }
        })
        .background(curiPalette(.paper500))
//        .presentationDragIndicator(.visible)
        .interactiveDismissDisabled(true)
    }
}

#Preview {
//    WidgetIntroducingView()
    @Previewable @State var sheetPresented: Bool = true
    VStack {

    }
    .sheet(isPresented: $sheetPresented) {
        WidgetIntroducingView()
    }
}
