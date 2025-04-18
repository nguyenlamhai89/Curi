//
//  TopNavigation.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI

struct TopNavigationUniversal: View {
    @Binding var settingsTopNavigation: Bool
    @Binding var widgetTopNavigation: Bool
    
    @Binding var isOpenedTabOne: Bool
    @Binding var isOpenedTabTwo: Bool
    
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
                    SegmentedControl(pageOneIsSelected: $isOpenedTabOne, pageTwoIsSelected: $isOpenedTabTwo)
                    
                    Spacer()
                    
                    /// Icon Button - Search
                    IconButtonDefault(iconName: "curiWidget") {
                        widgetTopNavigation.toggle()
                        print("Widget Introducing Navigated: \(widgetTopNavigation)")
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
    @Environment(\.dismiss) var dismiss
    var pageIsSelected: Bool
//    var bookName: String
    
    var body: some View {
//        VStack {
        LinearGradient(colors: [curiPalette(.paper500), curiPalette(.paper500).opacity(0)], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            .overlay {
                HStack {
                    /// Icon Button - User
                    if pageIsSelected {
                        IconButtonDefault(iconName: "curiLeft") {
                            dismiss()
                            print("Backed")
                        }
                    } else {
                        EmptyView()
                    }
                    
                    Spacer()
                    
                    /// Icon Button - Search
                    EmptyView()
                    
                }
                .padding(.horizontal, curiSpacing(.sp16))
                .frame(maxWidth: .infinity, alignment: .center)
//                .background(curiPalette(.paper50088))
            }
            .frame(height: 60)
//        }
//        .frame(height: 60)
//        .frame(maxWidth: .infinity, alignment: .center)
//        .background(curiPalette(.paper50088))
    }
}

#Preview {
    @Previewable @State var settingsTopNavigation: Bool = false
    @Previewable @State var widgetTopNavigation: Bool = false
    @Previewable @State var pageOneIsSelected: Bool = true
    @Previewable @State var pageTwoIsSelected: Bool = false
    
    TopNavigationUniversal(settingsTopNavigation: $settingsTopNavigation, widgetTopNavigation: $widgetTopNavigation, isOpenedTabOne: $pageOneIsSelected, isOpenedTabTwo: $pageTwoIsSelected)
    TopNavigationBook(pageIsSelected: true)
}
