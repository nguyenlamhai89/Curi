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
                    Button {
                        settingsTopNavigation.toggle()
                        print("Sheet On: \(settingsTopNavigation)")
                    } label: {
                        IconButtonDefault(iconName: "curiUser")
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
                    Button {
                        searchTopNavigation.toggle()
                        print("Search On: \(searchTopNavigation)")
                    } label: {
                        IconButtonDefault(iconName: "curiSearch")
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

#Preview {
    @Previewable @State var settingsTopNavigation: Bool = false
    @Previewable @State var searchTopNavigation: Bool = false
    TopNavigationCanvas(settingsTopNavigation: $settingsTopNavigation, searchTopNavigation: $searchTopNavigation)
}
