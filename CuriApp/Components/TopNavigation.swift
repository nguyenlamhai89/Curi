//
//  TopNavigation.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 1/3/25.
//

import SwiftUI
import Mixpanel

struct TopNavigationUniversal: View {
    @ObservedObject var bookViewModel: BookViewModel
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
                    IconButton(bookViewModel: bookViewModel, iconName: "curiUser", hasNote: false) {
                        settingsTopNavigation.toggle()
                        print("Settings Sheet Opened: \(settingsTopNavigation)")
                    }
                    
                    Spacer()
                    
                    /// Segmented Control
                    SegmentedControl(bookViewModel: bookViewModel, pageOneIsSelected: $isOpenedTabOne, pageTwoIsSelected: $isOpenedTabTwo)
                    
                    Spacer()
                    
                    /// Icon Button - Search
                    IconButton(bookViewModel: bookViewModel, iconName: "curiWidget", hasNote: false) {
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
    @ObservedObject var bookViewModel: BookViewModel
    @Environment(\.dismiss) var dismiss
    var pageIsSelected: Bool
    @Binding var highlightNewFeature: Bool
//    var bookName: String
    
    var body: some View {
//        VStack {
        LinearGradient(colors: [curiPalette(.paper500), curiPalette(.paper500).opacity(0)], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            .overlay {
                HStack {
                    /// Icon Button - User
                    if pageIsSelected {
                        IconButton(bookViewModel: bookViewModel, iconName: "curiLeft", hasNote: false) {
                            Mixpanel.mainInstance().track(event: "closed_Book")
                            dismiss()
                        }
                    } else {
                        EmptyView()
                    }
                    
                    Spacer()
                    
                    /// Icon Button - Search
                    if pageIsSelected {
                        IconButton(bookViewModel: bookViewModel, iconName: "curiHighlight", hasNote: false) {
                            highlightNewFeature.toggle()
                        }
                    } else {
                        EmptyView()
                    }
                    
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
    @Previewable @StateObject var bookViewModel = BookViewModel()
    @Previewable @State var settingsTopNavigation: Bool = false
    @Previewable @State var widgetTopNavigation: Bool = false
    @Previewable @State var pageOneIsSelected: Bool = true
    @Previewable @State var pageTwoIsSelected: Bool = false
    @Previewable @State var highlightNewFeature: Bool = false
    
    TopNavigationUniversal(bookViewModel: bookViewModel, settingsTopNavigation: $settingsTopNavigation, widgetTopNavigation: $widgetTopNavigation, isOpenedTabOne: $pageOneIsSelected, isOpenedTabTwo: $pageTwoIsSelected)
    TopNavigationBook(bookViewModel: bookViewModel, pageIsSelected: true, highlightNewFeature: $highlightNewFeature)
}
