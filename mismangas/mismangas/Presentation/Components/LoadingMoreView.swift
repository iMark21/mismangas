//
//  LoadingMoreView.swift
//  mismangas
//
//  Created by Michel Marques on 17/12/24.
//

import SwiftUI

struct LoadingMoreView: View {
    let message: String
    
    var body: some View {
        Spacer()
        ProgressMeView(message: message)
        Spacer()
    }
}

#Preview {
    LoadingMoreView(message: "Loading more...")
}
