//
//  Radius.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 26/2/25.
//

import SwiftUI

enum CuriRadius {
    case xs, s
    var radius: CGFloat {
        switch self {
        case .xs:
            return 1
        case .s:
            return 4
        }
    }
}

extension View {
    func curiRadius(_ radiusNumber: CuriRadius) -> CGFloat {
        return radiusNumber.radius
    }
}
