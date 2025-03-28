//
//  BookModel.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 14/3/25.
//

import SwiftUI

class Book: Identifiable, Codable {
    let id: UUID = UUID()
    let title: String
    let author: String
    let lines: [AttributedString]
}
