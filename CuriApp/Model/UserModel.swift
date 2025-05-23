//
//  UserModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 23/5/25.
//

import SwiftUI
import SwiftData

@Model
class User {
    var totalReadTime: Double = 0
    var soundInApp: Bool = true
    var vibrationInApp: Bool = true
    
    init(totalReadTime: Double, soundInApp: Bool, vibrationInApp: Bool) {
        self.totalReadTime = totalReadTime
        self.soundInApp = soundInApp
        self.vibrationInApp = vibrationInApp
    }
}
