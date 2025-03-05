//
//  TopNavigation.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI

struct TopNavigationCanvas: View {
    @Binding var settingsTopNavigation: Bool
    @Binding var searchTopNavigation: Bool
    
    var body: some View {
        VStack (spacing: 0) {
            ZStack {
                VStack {
                    VisualEffectView(effect: UIBlurEffect.init(style: .light))
                        .ignoresSafeArea()
                }
               
                HStack {
                    /// Icon Button - User
                    
                    IconButtonDefault(iconName: "curiUser") {
                        settingsTopNavigation.toggle()
                        print("Settings Sheet Opened: \(settingsTopNavigation)")
                    }
                    
                    Spacer()
                    
                    /// Segmented Control
                    SegmentedControl(content1: "Library", content2: "Quote") {
                        print("Button 1 Pressed")
                    } action2: {
                        print("Button 2 Pressed")
                    }
                    
                    Spacer()
                    
                    /// Icon Button - Search
                    IconButtonDefault(iconName: "curiSearch") {
                        searchTopNavigation.toggle()
                        print("Search Navigated: \(searchTopNavigation)")
                    }
                    
                }
                .padding(.horizontal, curiSpacing(.sp16))
                
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(curiPalette(.paper50088))
            
            Divider()
                .background(curiPalette(.paper300))
            Spacer()
        }
    }
}

struct TopNavigationBook: View {
    var body: some View {
        VStack {
            HStack {
                /// Icon Button - User
                
                IconButtonApp(iconName: "curiLeft", action: {
                    print("Back")
                })
                
                Spacer()
                
                /// Segmented Control
                Text("Sonnet")
                    .curiTypo(.sfMedium14)
                    .foregroundStyle(curiPalette(.ink500))
                
                Spacer()
                
                /// Icon Button - Search
                Rectangle()
                    .fill(curiPalette(.paper500))
                    .frame(width: 24, height: 24)
                
            }
            .padding(.horizontal, curiSpacing(.sp16))
            
        }
        .frame(height: 60)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(curiPalette(.paper50088))
    }
}

#Preview {
    @Previewable @State var settingsTopNavigation: Bool = false
    @Previewable @State var searchTopNavigation: Bool = false
    TopNavigationCanvas(settingsTopNavigation: $settingsTopNavigation, searchTopNavigation: $searchTopNavigation)
    TopNavigationBook()
}
