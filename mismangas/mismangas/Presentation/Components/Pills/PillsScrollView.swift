//
//  PillsScrollView.swift
//  mismangas
//
//  Created by Michel Marques on 21/1/25.
//

import SwiftUI

struct PillsScrollView: View {
    let title: String
    let items: [PillItem]
    @Binding var isLoading: Bool
    var onItemSelected: (PillItem) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(title.uppercased())
                .font(.headline)
                .bold()
                .padding(.bottom)

            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(items) { item in
                            Text(item.title)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Capsule())
                                .onTapGesture {
                                    onItemSelected(item)
                                }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    PillsScrollView(title: "Authors", items: PillItem.fromAuthors(Author.previewData), isLoading: .constant(false), onItemSelected: { _ in })
}
