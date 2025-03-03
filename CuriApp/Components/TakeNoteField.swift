//
//  TakeNoteField.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 3/3/25.
//

import SwiftUI

struct TakeNoteField: View {
    @Binding var shareThoughts: String
    
    var body: some View {
        VStack (spacing: curiSpacing(.sp8)) {
            VStack (alignment: .leading) {
                Text("Animal Farm")
                    .foregroundStyle(curiPalette(.ink500))
                Text("George Orwell")
                    .foregroundStyle(curiPalette(.ink300))
            }
            .curiTypo(.sfMedium12)
            .frame(maxWidth: .infinity, alignment: .leading)
//            .background(Color.yellow) // Check section
            
            TextField("Share your thoughts...", text: $shareThoughts)
                .curiTypo(.sfRegular16)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//                .background(Color.blue) // Check section
        }
        .padding(curiSpacing(.sp16))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.green) // Check section
        .background(curiPalette(.paper300))
        .cornerRadius(curiRadius(.rd8))
    }
}

#Preview {
    @Previewable @State var shareThoughts: String = ""
    TakeNoteField(shareThoughts: $shareThoughts)
}
