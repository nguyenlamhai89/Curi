//
//  CuriWidgetBundle.swift
//  CuriWidget
//
//  Created by Hai Lam Nguyen on 8/3/25.
//

import WidgetKit
import SwiftUI

@main
struct CuriWidgetBundle: WidgetBundle {
    var body: some Widget {
        CuriWidget()
        CuriWidgetControl()
        CuriWidgetLiveActivity()
    }
}
