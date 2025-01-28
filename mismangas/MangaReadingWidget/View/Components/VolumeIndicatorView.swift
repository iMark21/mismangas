//
//  VolumeIndicatorView.swift
//  mismangas
//
//  Created by Michel Marques on 28/1/25.
//

import SwiftUI
import WidgetKit

struct VolumeIndicatorView: View {
    let totalVolumes: Int
    let readingVolume: Int
    let maxWidth: CGFloat

    var body: some View {
        let spacing: CGFloat = 2
        let itemWidth = (maxWidth - CGFloat(totalVolumes - 1) * spacing) / CGFloat(totalVolumes)

        HStack(spacing: spacing) {
            ForEach(1...totalVolumes, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(colorForVolume(index: index, readingVolume: readingVolume))
                    .frame(width: itemWidth, height: 10)
            }
        }
        .frame(width: maxWidth, height: 10)
    }

    private func colorForVolume(index: Int, readingVolume: Int) -> Color {
        if readingVolume == totalVolumes {
            return index <= readingVolume ? .green : .gray.opacity(0.3)
        } else {
            return index <= readingVolume ? .blue : .gray.opacity(0.3)
        }
    }
}
