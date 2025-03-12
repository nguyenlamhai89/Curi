//
//  RenameHighlightView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 11/3/25.
//

import SwiftUI

struct RenameHighlightView: View {
    var backgroundColor: Color
    var placeholderHighlightName: String
    @Binding var highlightName: String
    @Binding var viewIsPresented: Bool
    
    @FocusState var autoFocus: Bool
    
    var body: some View {
        Rectangle()
            .fill(backgroundColor)
            .ignoresSafeArea()
            .overlay {
                VStack (spacing: curiSpacing(.sp2)) {
                    TextField(placeholderHighlightName, text: $highlightName)
                        .curiTypo(.sfRegular32)
                        .foregroundStyle(curiPalette(.paper500))
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .focused($autoFocus)
                        .submitLabel(.done)
                        .onSubmit {
                            withAnimation {
                                viewIsPresented.toggle()
                                print("Rename View On: \(viewIsPresented)")
                            }
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    autoFocus.toggle()
                }
            }
    }
}

#Preview {
    @Previewable @State var viewIsPresented: Bool = false
    @Previewable @State var highlightName: String = "Good Point"
    RenameHighlightView(backgroundColor: Color.pink, placeholderHighlightName: "Pink", highlightName: $highlightName, viewIsPresented: $viewIsPresented)
}
