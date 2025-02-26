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
                        .frame(height: 134)
                    
                    /// Main Content
                    VStack (spacing: 24) {
                        ForEach(0..<20) { index in
                            VStack {
                                Text("Text \(index)")
                                    .curiTypo(.bkRegular32)
                                Rectangle()
                                    .fill(curiPalette(.blue500))
                                    .frame(height: 80)
                            }
                        }
                    }
                    .padding(.horizontal, curiSpacing(.sp16))
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    HomeView()
}
