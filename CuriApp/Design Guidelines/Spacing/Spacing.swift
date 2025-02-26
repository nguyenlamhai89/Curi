//
//  Spacing.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

enum CuriSpacing {
    case sp32, sp20, sp16, sp12, sp8, sp4, sp2
    var spacing: CGFloat {
        switch self {
        case .sp32: return 32
        case .sp20: return 20
        case .sp16: return 16
        case .sp12: return 12
        case .sp8: return 8
        case .sp4: return 4
        case .sp2: return 2
        }
    }
}

extension View {
    func curiSpacing(_ curiSpacing: CuriSpacing) -> CGFloat {
        return curiSpacing.spacing
    }
}

struct Spacing: View {
    var body: some View {
        Button {
            print("Test Spacing")
        } label: {
            Text("Space")
                .curiTypo(.bkRegular16)
                .foregroundStyle(curiPalette(.paper500))
                .padding(curiSpacing(.sp20))
                .frame(maxWidth: .infinity)
                .background(curiPalette(.ink500))
                .cornerRadius(curiRadius(.rd4))
        }

    }
}

#Preview {
    Spacing()
}
