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
        case highlightClicked, highlightDone
        var fileName: String {
            switch self {
            case .highlightClicked:
                return "highlight-button"
            case .highlightDone:
                return "highlighted"
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
            SoundManager.access.play(sound: .highlightClicked)
            HapticsManager.access.play(haptics: .light)
        } label: {
            Text("Button Sound")
        }
        
        Button {
            SoundManager.access.play(sound: .highlightDone)
            HapticsManager.access.play(haptics: .heavy)
        } label: {
            Text("Highlight Sound")
        }

    }
}

#Preview {
    SoundEffect()
}
