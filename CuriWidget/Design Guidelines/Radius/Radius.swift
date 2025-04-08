//
//  Radius.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

enum CuriRadius {
    case rd1, rd4, rd8, rdMax
    var radius: CGFloat {
        switch self {
        case .rd1:
            return 1
        case .rd4:
            return 4
        case .rd8:
            return 8
        case .rdMax:
            return 100
        }
    }
}

extension View {
    func curiRadius(_ radiusNumber: CuriRadius) -> CGFloat {
        return radiusNumber.radius
    }
}

#Preview {
    Text("Hello World!")
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.cyan)
        .foregroundStyle(Color.white)
}
