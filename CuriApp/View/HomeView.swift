//
//  HomeView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

struct HomeView: View {
    @State var userSettingsIsOn: Bool = false
    var body: some View {
        ZStack {
            /// Top Navigation Bar
            VStack (spacing: 0) {
                HStack {
                    /// Icon Button - User
                    Button {
                        userSettingsIsOn.toggle()
                        print("Sheet On: \(userSettingsIsOn)")
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
                        print("Searching...")
                    } label: {
                        IconButtonDefault(iconName: "curiSearch")
                    }
                    
                }
                .padding(.horizontal, curiSpacing(.sp16))
                .frame(height: 60)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(curiPalette(.paper50088))
                Divider()
                    .background(curiPalette(.paper300))
                Spacer()
            }
            .zIndex(1)
            
            /// Library View
            ScrollView {
                VStack (spacing: curiSpacing(.sp20)) {
                    
                    /// Banner
                    HStack (alignment: .bottom) {
                        VStack (alignment: .leading) {
                            Text("Sonnet")
                                .curiTypo(.sfMedium32)
                                .lineLimit(1)
                            Text("William Shakespeare")
                                .curiTypo(.sfMedium16)
                                .lineLimit(1)
                        }
                        .foregroundStyle(curiPalette(.paper500))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Button {
                            print("Read Now")
                        } label: {
                            Text("Read Now")
                                .curiTypo(.sfMedium14)
                                .foregroundStyle(curiPalette(.ink500))
                                .padding(.vertical, curiSpacing(.sp4))
                                .padding(.horizontal, curiSpacing(.sp8))
                                .background(curiPalette(.paper500))
                                .cornerRadius(curiRadius(.rdMax))
                            
                        }
                    }
                    .frame(height: 200, alignment: .bottomLeading)
                    .frame(maxWidth: .infinity)
                    .padding(curiSpacing(.sp16))
                    .background(
                        Image("curiBannerSample")
                            .resizable()
                            .scaledToFill()
                    )
                    .cornerRadius(curiRadius(.rd4))
                    
                    /// Library
                    VStack (alignment: .leading, spacing: curiSpacing(.sp8)) {
                        Text("For You")
                            .curiTypo(.sfMedium14)
                            .foregroundStyle(curiPalette(.ink300))
                        VStack (spacing: curiSpacing(.sp12)) {
                            ForEach(0..<10) { bookNum in
                                NavigationLink {
                                    Text("Book \(bookNum)")
                                } label: {
                                    VStack {
                                        VStack (alignment: .leading) {
                                            Text("Book \(bookNum)")
                                                .curiTypo(.sfMedium32)
                                                .foregroundStyle(curiPalette(.ink500))
                                                .lineLimit(2)
                                            Text("Author")
                                                .curiTypo(.sfRegular16)
                                                .foregroundStyle(curiPalette(.ink300))
                                                .lineLimit(1)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        Divider()
                                            .background(curiPalette(.ink100))
                                    }
                                    
                                    
                                }

                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                }
                .padding(.top, 80)
                .padding(.horizontal, curiSpacing(.sp16))
            }
            .scrollIndicators(.hidden)
        }
        .toolbar(.hidden)
        .background(curiPalette(.paper500))
        .sheet(isPresented: $userSettingsIsOn) {
            UserSettingsSheetView()
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    HomeView()
}
