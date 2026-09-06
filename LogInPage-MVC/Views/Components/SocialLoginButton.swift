//
//  SocialLoginButton.swift
//  LogInPage-MVC
//
//  Created by Z.K   on 06/09/2026.
//

import SwiftUI

/// A single social-login option: icon above a label, tappable as one unit.
struct SocialLoginButton: View {
    enum Provider {
        case google, apple, facebook

        var label: String {
            switch self {
            case .google: return "Google"
            case .apple: return "Apple"
            case .facebook: return "Facebook"
            }
        }

        var accessibilityLabel: String {
            "Sign in with \(label)"
        }
    }

    let provider: Provider
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                iconView
                    .frame(width: 22, height: 22)

                Text(provider.label)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(AppTheme.secondaryText)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(AppTheme.socialChipBackground)
            .clipShape(RoundedRectangle(cornerRadius: LoginRadius.field))
        }
        .accessibilityLabel(provider.accessibilityLabel)
    }

    @ViewBuilder
    private var iconView: some View {
        switch provider {
        case .google:
            // Simple vector "G" mark approximating the Google logo colors.
            Text("G")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.blue, .red, .yellow, .green],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        case .apple:
            Image(systemName: "apple.logo")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
        case .facebook:
            Image(systemName: "f.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(red: 0.26, green: 0.40, blue: 0.70))
        }
    }
}
