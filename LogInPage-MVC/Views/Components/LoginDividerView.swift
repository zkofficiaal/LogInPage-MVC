//
//  LoginDividerView.swift
//  LogInPage-MVC
//
//  Created by Z.K   on 06/09/2026.
//

import SwiftUI

/// "OR CONTINUE WITH" divider between the primary action and social logins.
struct LoginDividerView: View {
    var text: String = "OR CONTINUE WITH"

    var body: some View {
        Text(text)
            .font(.system(size: 11, weight: .semibold))
            .foregroundColor(AppTheme.secondaryText)
            .tracking(0.5)
    }
}
