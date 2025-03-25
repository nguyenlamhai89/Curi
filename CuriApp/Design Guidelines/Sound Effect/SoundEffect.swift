//
//  SoundEffect.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 18/3/25.
//

import SwiftUI
import AVKit

class SoundManager {
    static let access = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundCase {
        case iconButton, highlightRename, highlightRemoved, highlightAdded
        var fileName: String {
            switch self {
            case .iconButton:
                return "iconButton"
            case .highlightRename:
                return "highlightRename"
            case .highlightRemoved:
                return "highlightRemoved"
            case .highlightAdded:
                return "highlightAdded"
            }
        }
    }
    
    func play(sound: SoundCase) {
        guard let url = Bundle.main.url(forResource: sound.fileName, withExtension: ".wav") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound: \(error)")
        }
    }
}

struct SoundEffect: View {
    var body: some View {
        Button {
            SoundManager.access.play(sound: .highlightRemoved)
            HapticsManager.access.play(haptics: .light)
        } label: {
            Text("Button Sound")
        }
        
        Button {
            SoundManager.access.play(sound: .highlightAdded)
            HapticsManager.access.play(haptics: .heavy)
        } label: {
            Text("Highlight Sound")
        }

    }
}

#Preview {
    SoundEffect()
}
