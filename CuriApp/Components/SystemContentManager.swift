//
//  SystemContentManager.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 31/5/25.
//

import SwiftUI

class SystemContentManager {
    static let access = SystemContentManager()
    
    /// Alert
    var titleDelete: String = "This quote includes a note"
    var messageDelete: String = "Are you sure you want to delete both?"
    var buttonDelete: String = "Delete"
}
