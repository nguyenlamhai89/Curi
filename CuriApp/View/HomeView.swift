//
//  HomeView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(curiPalette(.paper500))
                    .ignoresSafeArea()
                ZStack {
                    /// Top Nav - Canvas
                    VStack (spacing: 0) {
                        HStack {
                            /// Icon Button - User
                            Button {
                                print("Pressed")
                            } label: {
                                Image("curiUser")
                                    .frame(width: 32, height: 32)
                                    .background(curiPalette(.ink100))
                                    .cornerRadius(curiRadius(.rdMax))
                            }
                            
                            Spacer()
                            
                            /// Segmented Control
                            HStack (spacing: curiSpacing(.sp4)) {
                                Button {
                                    print("Switch")
                                } label: {
                                    Text("Library")
                                        .curiTypo(.sfMedium14)
                                        .foregroundStyle(curiPalette(.ink500))
                                        .padding(.vertical, curiSpacing(.sp2))
                                        .padding(.horizontal, curiSpacing(.sp8))
                                        .background(curiPalette(.paper500))
                                        .cornerRadius(curiRadius(.rdMax))
                                }
                                Button {
                                    print("Switch")
                                } label: {
                                    Text("Quote")
                                        .curiTypo(.sfMedium14)
                                        .foregroundStyle(curiPalette(.paper500))
                                        .padding(.vertical, curiSpacing(.sp2))
                                        .padding(.horizontal, curiSpacing(.sp8))
                                        .background(curiPalette(.ink100))
                                        .cornerRadius(curiRadius(.rdMax))
                                }
                            }
                            .padding(curiSpacing(.sp4))
                            .background(curiPalette(.ink100))
                            .cornerRadius(curiRadius(.rdMax))
                            
                            Spacer()
                            
                            /// Icon Button - Search
                            Button {
                                print("Pressed")
                            } label: {
                                Image("curiSearch")
                                    .frame(width: 32, height: 32)
                                    .background(curiPalette(.ink100))
                                    .cornerRadius(curiRadius(.rdMax))
                            }
                            
                        }
                        .padding(.horizontal, curiSpacing(.sp16))
                        .frame(height: 60)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(curiPalette(.paper50088))
//                        .background(Color.blue) // Check section
                        Divider()
                            .background(curiPalette(.paper300))
                        Spacer()
                    }
                }
                .zIndex(1)
                
                ScrollView {
                    /// Fake Spacing
                    Rectangle()
                        .fill(curiPalette(.paper500))
                        .frame(height: 80)
                    
                    /// Main Content
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
//                                .background(Color.green) // Check section
                            Button {
                                print("Read Now")
                            } label: {
                                Text("Read Now")
                                    .curiTypo(.sfMedium14)
                                    .foregroundStyle(curiPalette(.ink500))
                                    .padding(.vertical, curiSpacing(.sp4))
                                    .padding(.horizontal, curiSpacing(.sp8))
//                                    .background(Color.red) // Check section
                                    .background(curiPalette(.paper500))
                                    .cornerRadius(curiRadius(.rdMax))
                                
                            }
                        }
                        .frame(height: 200, alignment: .bottomLeading)
                        .frame(maxWidth: .infinity)
                        .padding(curiSpacing(.sp16))
//                        .background(Color.yellow) // Check section
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
//                                .background(Color.yellow) // Check section
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
                                                //                                    .background(Color.blue) // Check section
                                                    .lineLimit(2)
                                                Text("Author")
                                                    .curiTypo(.sfRegular16)
                                                    .foregroundStyle(curiPalette(.ink300))
                                                //                                    .background(Color.green) // Check section
                                                    .lineLimit(1)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                            .background(curiPalette(.blue300)) // Check section
                                            Divider()
                                                .background(curiPalette(.ink100))
                                        }
                                        
                                        
                                    }

                                    //                            .background(Color.cyan) // Check section
                                }
                            }
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .background(Color.red) // Check section

                    }
                    .padding(.horizontal, curiSpacing(.sp16))
                }
                .scrollIndicators(.hidden)
            }
        }
        .toolbar(.hidden)
    }
}

#Preview {
    HomeView()
}
