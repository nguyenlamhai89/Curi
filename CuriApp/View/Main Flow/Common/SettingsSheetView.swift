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
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) private var openURL
    
    @ObservedObject var bookViewModel: BookViewModel
    @Query var pencilDatabase: [HighlightPencil] = []
    
    let curiLogoGIF: String = "curiLogoGIF.gif"
    
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
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .cornerRadius(curiRadius(.rd8))
                    
                    ToggleGroupButton(isOn: $bookViewModel.soundInApp, buttonImage: "curiSound", buttonName: "Sound", buttonDescription: "Hear a note with every highlight and button.")
                    
                    ToggleGroupButton(isOn: $bookViewModel.vibrationInApp, buttonImage: "curiVibration", buttonName: "Vibration", buttonDescription: "Feel each moment you press.")
                    
                    /// Link Buttons
                    VStack (spacing: curiSpacing(.sp8)) {
                        ForEach(aboutButtons.indices, id: \.self) { buttonInfo in
                            LinkButton(bookViewModel: bookViewModel, buttonName: aboutButtons[buttonInfo].1, urlString: aboutButtons[buttonInfo].0)
                        }
                    }
                    .padding(curiSpacing(.sp8))
                    .background(curiPalette(.paper300))
                    .cornerRadius(curiRadius(.rd8))
                    
                    /// About Curi
                    VStack (spacing: curiSpacing(.sp20)) {
                        AnimatedImage(name: curiLogoGIF, isAnimating: .constant(true))
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
            .navigationTitle("Curi")
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
                print("🖍️ Available Highlight Pencils: \(pencilDatabase.count)")
                for (index, pen) in pencilDatabase.enumerated() {
                    print(String(describing: "--- [\(index + 1)] Pencil: \(pen.name), Color: \(pen.primaryBackgroundColor)"))
                }
            }
            .onChange(of: bookViewModel.soundInApp) {
                print("Sound: \(bookViewModel.soundInApp ? "On" : "Off")")
            }
            .onChange(of: bookViewModel.vibrationInApp) {
                print("Vibration: \(bookViewModel.vibrationInApp ? "On" : "Off")")
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var bookViewModel = BookViewModel()
    Text("Sample")
        .sheet(isPresented: .constant(true)) {
            SettingsSheetView(bookViewModel: bookViewModel)
        }
}
