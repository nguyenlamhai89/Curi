//
//  RenameHighlightView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 11/3/25.
//

import SwiftUI
import WidgetKit

struct RenameHighlightView: View {
    @Binding var highlightName: String
    @FocusState var autoFocusRename: Bool
    
    var backgroundColor: Color
    var placeholderHighlightName: String = "Highlight Name"
    
    var onSaveNewName: () -> Void
    
    var body: some View {
        Rectangle()
            .fill(backgroundColor)
            .ignoresSafeArea()
            .overlay {
                VStack (spacing: curiSpacing(.sp2)) {
                    Text("This name will be used for other quotes")
                        .curiTypo(.sfMedium14)
                        .foregroundStyle(curiPalette(.paper500))
                        .multilineTextAlignment(.center)
                    TextField(placeholderHighlightName, text: $highlightName)
                        .curiTypo(.sfRegular32)
                        .foregroundStyle(curiPalette(.paper500))
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .focused($autoFocusRename)
                        .submitLabel(.done)
                        .onSubmit {
                            withAnimation {
                                onSaveNewName()
                            }
                            WidgetCenter.shared.reloadTimelines(ofKind: "curiWidget")
                        }
                        .onChange(of: highlightName) { oldValue, newValue in
                            highlightName = newValue.prefix(20).description
                        }
                    Text("\(highlightName.count)")
                        .curiTypo(.sfMedium12)
                        .foregroundStyle(curiPalette(.paper500))
                        .frame(maxWidth: .infinity)
                }
            }
            .onAppear {
                DispatchQueue.main.async {
                    autoFocusRename.toggle()
                }
            }
    }
}
