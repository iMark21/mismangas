//
//  AuthCredentialsFormView.swift
//  mismangas
//
//  Created by Michel Marques on 24/1/25.
//

import SwiftUI

struct AuthCredentialsFormView: View {
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var email = ""
    @Previewable @State var password = ""

    AuthCredentialsFormView(email: $email, password: $password)
}
