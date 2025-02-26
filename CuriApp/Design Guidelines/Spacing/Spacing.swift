//
//  Spacing.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

enum CuriSpacing {
    case xxl, xl, l, m, s, xs, xxs
    var spacing: CGFloat {
        switch self {
        case .xxl: return 32
        case .xl: return 20
        case .l: return 16
        case .m: return 12
        case .s: return 8
        case .xs: return 4
        case .xxs: return 2
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
                .padding(curiSpacing(.xl))
                .frame(maxWidth: .infinity)
                .background(curiPalette(.ink500))
                .cornerRadius(curiRadius(.s))
        }

    }
}

#Preview {
    Spacing()
}
