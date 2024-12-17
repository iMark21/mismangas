//
//  ProgressView.swift
//  mismangas
//
//  Created by Michel Marques on 17/12/24.
//

import SwiftUI

struct ProgressMeView: View {
    let message: String
    
    var body: some View {
        ProgressView(message)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ProgressMeView(message: "Loading...")
}
