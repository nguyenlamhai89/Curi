//
//  UserSettingsView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 27/2/25.
//

import SwiftUI
import SwiftData
import SDWebImageSwiftUI

struct SettingsSheetView: View {
    /// SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var pencilDatabase: [HighlightPencil] = []
    @Query var userSettings: [User]
    
    /// Local View
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) private var openURL
    @ObservedObject var bookViewModel: BookViewModel
    let curiSettingsGIF: String = "curiSettingsGIF.gif"
    let aboutButtons: [(String, String)] = [
        ("https://www.facebook.com/nhammmmmmm/", "Give Feedback"),
        ("https://drive.google.com/file/d/1L3YO_D4Gq5zxfv6hTYpUc2W-YoeThxse/view?usp=sharing", "Support My Wedding Dream"),
        ("https://www.notion.so/Curi-1e6780c3688c80168526c48a842c7b8d?pvs=4", "Terms and Privacy"),
        ("https://www.thomaswilliams-sound.com", "Music by Thomas William")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: curiSpacing(.sp20)) {
                    /// Image
                    Rectangle()
                        .fill(curiPalette(.ink500))
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .cornerRadius(curiRadius(.rd8))
                        .overlay {
                            VStack {
                                Spacer()
                                ZStack {
                                    AnimatedImage(name: curiSettingsGIF)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 160)
                                    
                                    if bookViewModel.selectedPen?.primaryBackgroundColor == "blue-300" {
                                        Image("curiBluePen")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 160)
                                    } else if bookViewModel.selectedPen?.primaryBackgroundColor == "pink-300" {
                                        Image("curiPinkPen")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 160)
                                    } else {
                                        EmptyView()
                                    }
                                }
                            }
                        }
                    
                    ReadingAnalyticsView()
                    
                    ToggleGroupButton(isOn: $bookViewModel.soundInApp, buttonImage: "curiSound", buttonName: "Sound", buttonDescription: "Hear a note with every highlight and button.")
                    
                    ToggleGroupButton(isOn: $bookViewModel.vibrationInApp, buttonImage: "curiVibration", buttonName: "Vibration", buttonDescription: "Feel each moment you press.")
                    
                    /// Link Buttons
                    VStack (spacing: curiSpacing(.sp8)) {
                        ForEach(aboutButtons.indices, id: \.self) { buttonInfo in
                            LinkButton(bookViewModel: bookViewModel, buttonName: aboutButtons[buttonInfo].1, urlString: aboutButtons[buttonInfo].0)
                                .simultaneousGesture(DragGesture())
                            Divider()
                                .background(curiPalette(.ink100))
                        }
                    }
                    
                    /// About Curi
                    VStack (spacing: curiSpacing(.sp20)) {
                        Image("curiLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                        
                        VStack (spacing: curiSpacing(.sp8)) {
                            Text("Curi transforms your reading experience into something more memorable and enjoyable.")
                            Text("🇻🇳 Hanoi, Vietnam 🇻🇳")
                        }
                        .curiTypo(.bkRegular14)
                        .foregroundStyle(curiPalette(.ink500))
                        .multilineTextAlignment(.center)
                    }
                    .padding(.top, curiSpacing(.sp32))
                }
                .padding(curiSpacing(.sp16))
            }
//            .navigationTitle("Curi")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(spacing: -4) {
                        Text("Curi")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(curiPalette(.ink500))
                        Text("iCloud Synced: \(Date().formatted(date: .abbreviated, time: .shortened))")
                            .curiTypo(.sfMedium14)
                            .foregroundColor(curiPalette(.ink300))
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(curiPalette(.paper500))
//            .presentationDragIndicator(.visible)
            .interactiveDismissDisabled(true)
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    IconButton(bookViewModel: bookViewModel, iconName: "curiDelete", hasNote: false) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .onAppear {
                if userSettings.count != 1 {
                    print("❌ Only contains 1 US")
                } else {
                    print("✅ User Settings: \(userSettings)")
                }
                print("🖍️ Available Highlight Pencils: \(pencilDatabase.count)")
                for (index, pen) in pencilDatabase.enumerated() {
                    print(String(describing: "--- [\(index)] Pencil: \(pen.name), Color: \(pen.primaryBackgroundColor)"))
                }
                
                // Check Quote Of The Day
                print("--- QOTD: [\(String(describing: bookViewModel.lineNumOnWidget))] \(bookViewModel.quoteOnWidget) - \(bookViewModel.highlightNameOnWidget) - \(bookViewModel.highlightColorOnWidget)")
            }
            .onChange(of: bookViewModel.soundInApp) {
                userSettings[0].soundInApp = bookViewModel.soundInApp
                print("Sound: \(bookViewModel.soundInApp ? "On" : "Off")")
            }
            .onChange(of: bookViewModel.vibrationInApp) {
                userSettings[0].vibrationInApp = bookViewModel.vibrationInApp
                print("Vibration: \(bookViewModel.vibrationInApp ? "On" : "Off")")
            }
        }
    }
}
