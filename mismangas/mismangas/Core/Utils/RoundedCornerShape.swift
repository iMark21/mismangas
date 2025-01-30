//
//  RoundedCornerShape.swift
//  mismangas
//
//  Created by Michel Marques on 21/1/25.
//

import SwiftUI

#if os(iOS)
struct RoundedCornerShape: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
#endif
