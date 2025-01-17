//
//  MangaDetailBottomBar.swift
//  mismangas
//
//  Created by Michel Marques on 17/1/25.
//


import SwiftUI

struct MangaDetailBottomBar: View {
    @Binding var isInCollection: Bool
    let toggleCollection: () -> Void
    let showManagement: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Button(action: toggleCollection) {
                VStack {
                    Image(systemName: isInCollection ? "minus.circle.fill" : "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                    Text(isInCollection ? "Remove" : "Add to collection")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(isInCollection ?
                            LinearGradient(colors: [Color.red, Color.pink], startPoint: .top, endPoint: .bottom) :
                                LinearGradient(colors: [Color.blue, Color.cyan], startPoint: .top, endPoint: .bottom))
                .cornerRadius(12)
                .shadow(color: isInCollection ? Color.red.opacity(0.3) : Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
            }

            Button(action: showManagement) {
                VStack {
                    Image(systemName: "gearshape.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                    Text("Manage")
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .padding(.bottom, 16)
        .background(Color(UIColor.systemBackground))
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var isInCollection = false
    
    return MangaDetailBottomBar(isInCollection: $isInCollection,
                                toggleCollection: {},
                                showManagement: {}
    )
}
