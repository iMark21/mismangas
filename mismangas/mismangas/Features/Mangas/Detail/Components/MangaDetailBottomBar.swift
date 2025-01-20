//
//  MangaDetailBottomBar.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//

import SwiftUI

struct MangaDetailBottomBar: View {
    var isInCollection: Bool
    let toggleCollection: () -> Void
    let showManagement: (() -> Void)?
    var showManageButton: Bool = true

    var body: some View {
        HStack(spacing: 12) {
            Button(action: toggleCollection) {
                HStack {
                    Image(systemName: isInCollection ? "minus.circle" : "plus.circle")
                        .font(.title3)
                    Text(isInCollection ? "Remove" : "Add")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(isInCollection ? Color.red : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }

            if showManageButton, let showManagement = showManagement {
                Button(action: showManagement) {
                    HStack {
                        Image(systemName: "gearshape")
                            .font(.title3)
                        Text("Manage")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.systemGray5))
                    .foregroundColor(.primary)
                    .cornerRadius(8)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var isInCollection = false
    return MangaDetailBottomBar(
        isInCollection: isInCollection,
        toggleCollection: {},
        showManagement: nil,
        showManageButton: true
    )
}
