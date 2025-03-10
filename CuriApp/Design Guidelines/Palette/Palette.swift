//
//  Palette.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

enum CuriPalette {
    case pink100, pink300, pink500
    case blue100, blue300, blue500
    case paper300, paper500, paper50088
    case ink100, ink300, ink500
    
    var color: Color {
        switch self {
        case .pink100:
            return Color("pink-100")
        case .pink300:
            return Color("pink-300")
        case .pink500:
            return Color("pink-500")
            
        case .blue100:
            return Color("blue-100")
        case .blue300:
            return Color("blue-300")
        case .blue500:
            return Color("blue-500")
            
        case .paper300:
            return Color("paper-300")
        case .paper500:
            return Color("paper-500")
        case .paper50088:
            return Color("paper-500-88")
            
        case .ink100:
            return Color("ink-100")
        case .ink300:
            return Color("ink-300")
        case .ink500:
            return Color("ink-500")
        }
    }
}

extension View {
    func curiPalette(_ curiColor: CuriPalette) -> Color {
        return curiColor.color
    }
}

struct Palette: View {
    var body: some View {
        Text("Hello")
            .curiTypo(.bkRegular32)
            .foregroundStyle(curiPalette(.pink500))
        Button {
            print("Test color")
        } label: {
            Text("Sign in with Apple")
                .curiTypo(.sfRegular16)
                .foregroundStyle(curiPalette(.paper500))
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(curiPalette(.ink500))
                .cornerRadius(100)
                .padding(.horizontal, 16)
        }
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

#Preview {
    Palette()
}
