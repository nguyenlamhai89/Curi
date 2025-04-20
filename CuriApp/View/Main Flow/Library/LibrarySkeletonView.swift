//
//  SkeletonView.swift
//  CuriApp
//
//  Created by Hai Lam Nguyen on 28/3/25.
//

import SwiftUI

struct LibrarySkeletonView: View {
    @Bindable var bookViewModel: BookViewModel
    
    var body: some View {
        ScrollView {
            VStack (spacing: curiSpacing(.sp20)) {
                /// MARK - Banner
                SkeletonBlock(loadingState: bookViewModel.isLoading)
                    .frame(height: 232)
                
                /// MARK - Book List
                VStack (alignment: .leading, spacing: curiSpacing(.sp8)) {
                    SkeletonBlock(loadingState: bookViewModel.isLoading)
                        .frame(width: 100, height: 24)

                    ForEach(0..<10) { _ in
                        SkeletonBlock(loadingState: bookViewModel.isLoading)
                            .frame(height: 80)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
            .padding(.top, 80)
            .padding(.horizontal, curiSpacing(.sp16))
        }
        .scrollIndicators(.hidden)
    }
}


#Preview {
    @Previewable @Bindable var bookViewModel = BookViewModel()
    LibrarySkeletonView(bookViewModel: bookViewModel)
}
