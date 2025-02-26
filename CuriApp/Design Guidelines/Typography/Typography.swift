//
//  Typography.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 20/2/25.
//

import SwiftUI

/// MARK: Typeface
let sfProMedium = "SF-Pro-Display-Medium"
let sfProRegular = "SF-Pro-Display-Regular"
let bookerlyBold = "Bookerly Bold"
let bookerlyRegular = "Bookerly"

/// Font
enum CuriFont {
    case sfMedium32, sfRegular32, sfMedium16, sfRegular16, sfMedium14, sfMedium12
    case bkRegular32, bkBold16, bkRegular16, bkRegular14, bkRegular12
    
    var font: Font {
        switch self {
        case .sfMedium32:
            return .custom(sfProMedium, size: self.fontSize)
        case .sfRegular32:
            return .custom(sfProRegular, size: self.fontSize)
        case .sfMedium16:
            return .custom(sfProMedium, size: self.fontSize)
        case .sfRegular16:
            return .custom(sfProRegular, size: self.fontSize)
        case .sfMedium14:
            return .custom(sfProMedium, size: self.fontSize)
        case .sfMedium12:
            return .custom(sfProMedium, size: self.fontSize)
          
        case .bkRegular32:
            return .custom(bookerlyRegular, size: self.fontSize)
        case .bkBold16:
            return .custom(bookerlyBold, size: self.fontSize)
        case .bkRegular16:
            return .custom(bookerlyRegular, size: self.fontSize)
        case .bkRegular14:
            return .custom(bookerlyRegular, size: self.fontSize)
        case .bkRegular12:
            return .custom(bookerlyRegular, size: self.fontSize)
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .sfMedium32, .sfRegular32, .bkRegular32: return 48
        case .sfMedium16, .sfRegular16, .sfMedium14, .bkBold16, .bkRegular16, .bkRegular14: return 24
        case .sfMedium12, .bkRegular12: return 16
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .sfMedium32, .sfRegular32, .bkRegular32: return 32
        case .sfMedium16, .sfRegular16, .bkBold16, .bkRegular16: return 16
        case .sfMedium14, .bkRegular14: return 14
        case .sfMedium12, .bkRegular12: return 12
        }
    }
}

extension View {
    func curiTypography(_ style: CuriFont) -> some View {
        self.font(style.font).lineSpacing((style.lineHeight - style.fontSize)/2)
    }
}


struct Typography: View {
    var body: some View {
        Text("Hello")
            .curiTypography(.bkRegular32)
    }
}

#Preview {
    Typography()
}
