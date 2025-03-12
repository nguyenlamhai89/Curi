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
    
    @Binding var pageOneIsSelected: Bool
    @Binding var pageTwoIsSelected: Bool
    
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
                    SegmentedControl(pageOneIsSelected: $pageOneIsSelected, pageTwoIsSelected: $pageTwoIsSelected)
                    
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
    @Environment(\.dismiss) var dismiss
    var quoteIsSelected: Bool
    var bookName: String
    
    var body: some View {
        VStack {
            HStack {
                /// Icon Button - User
                
                if quoteIsSelected {
                    IconButtonApp(iconName: "curiLeft", action: {
                        dismiss()
                        print("Back")
                    })
                } else {
                    Rectangle()
                        .fill(curiPalette(.paper500))
                        .frame(width: 32, height: 32)
                }
                
                Spacer()
                
                /// Segmented Control
                if quoteIsSelected {
                    Text("\(bookName)")
                        .curiTypo(.sfMedium14)
                        .foregroundStyle(curiPalette(.ink500))
                } else {
                    Rectangle()
                        .fill(curiPalette(.paper500))
                        .frame(maxWidth: .infinity)
                }
                
                Spacer()
                
                /// Icon Button - Search
                Rectangle()
                    .fill(curiPalette(.paper500))
                    .frame(width: 32, height: 32)
                
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
    @Previewable @State var pageOneIsSelected: Bool = true
    @Previewable @State var pageTwoIsSelected: Bool = false
    
    TopNavigationCanvas(settingsTopNavigation: $settingsTopNavigation, searchTopNavigation: $searchTopNavigation, pageOneIsSelected: $pageOneIsSelected, pageTwoIsSelected: $pageTwoIsSelected)
    TopNavigationBook(quoteIsSelected: true, bookName: "Sonnet")
}
