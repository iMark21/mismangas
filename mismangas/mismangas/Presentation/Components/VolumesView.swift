//
//  VolumesView.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//


import SwiftUI

struct VolumesView: View {
    let volumes: Int

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "books.vertical.fill")
                .foregroundColor(.white)
                .font(.caption)

            Text("\(volumes) \(volumes == 1 ? "Volume" : "Volumes")")
                .font(.caption.bold())
                .foregroundColor(.white)
        }
    }
}

#Preview {
    VolumesView(volumes: 14)
}
