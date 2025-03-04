//
//  QuoteNoteView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 3/3/25.
//

import SwiftUI

struct QuoteNoteSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var shareThoughts: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                VStack (spacing: curiSpacing(.sp20)){
                    VStack (spacing: curiSpacing(.sp8)) {
                        HighlightTag(content: "Discuss Later")
                        Text("All that year the animals worked like slaves. But they were happy in their work; they grudged no effort or sacrifice, well aware that everything they did was for the benefit of themselves and those of their kind who would come after them, and not for a pack of idle, thieving human beings.")
                            .curiTypo(.bkRegular16)
                            .foregroundStyle(curiPalette(.ink500))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                        HStack (spacing: curiSpacing(.sp8)) {
                            TextButtonFilledIcon(content: "Go to Book", icon: "curiBook", action: {
                                print("Go to Book")
                            })
                            TextButtonFilledIcon(content: "Connect", icon: "curiConnect", action: {
                                print("Connect")
                            })
                        }
                    }
                    
                    TakeNoteField(shareThoughts: $shareThoughts)
                }
                .navigationTitle("Quote")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Done")
                                .fontWeight(.semibold)
                                .foregroundStyle(curiPalette(.ink500))
                        }
                    }
                }
                
                TextButtonPlain(content: "Delete Quote and Note", action: {
                    print("Delete")
                })
                .frame(height: 80)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.horizontal, curiSpacing(.sp16))
            .background(curiPalette(.paper500))
            .navigationTitle("Quote")
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDragIndicator(.hidden)
        .interactiveDismissDisabled(true)
    }
}

#Preview {
    QuoteNoteSheetView()
}
