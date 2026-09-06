//
//  LoginFooterView.swift
//  LogInPage-MVC
//
//  Created by Z.K   on 06/09/2026.
//

import SwiftUI

struct LoginFooterView: View {
    var onPrivacyTap: () -> Void
    var onTermsTap: () -> Void

    var body: some View {
        HStack(spacing: 28) {
            Button(action: onPrivacyTap) {
                HStack(spacing: 5) {
                    Image(systemName: "checkmark.shield")
                        .font(.system(size: 11))
                    Text("Privacy")
                        .font(.system(size: 11, weight: .medium))
                }
            }
            .accessibilityLabel("Privacy policy")

            Button(action: onTermsTap) {
                HStack(spacing: 5) {
                    Image(systemName: "doc.text")
                        .font(.system(size: 11))
                    Text("Terms")
                        .font(.system(size: 11, weight: .medium))
                }
            }
            .accessibilityLabel("Terms of service")
        }
        .foregroundColor(AppTheme.secondaryText)
    }
}
