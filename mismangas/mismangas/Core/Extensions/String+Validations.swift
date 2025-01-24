//
//  String+Validations.swift
//  mismangas
//
//  Created by Michel Marques on 23/1/25.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
