//
//  LoginHeaderView.swift
//  LogInPage-MVC
//
//  Created by Z.K   on 06/09/2026.
//

import SwiftUI

struct LoginHeaderView: View {
    var body: some View {
        ZStack {
            LoginHeaderWaveShape()
                .fill(AppTheme.accentGreen)
                .ignoresSafeArea(edges: .top)

            VStack(spacing: LoginSpacing.small) {
                logoMark
                    .padding(.bottom, 2)

                Text("Welcome Back")
                    .font(.system(size: 27, weight: .bold))
                    .foregroundColor(AppTheme.onAccentPrimary)

                Text("Sign in to access your wallet and\nmanage your assets securely.")
                    .font(.system(size: 12, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(AppTheme.onAccentSecondary)
                    .lineSpacing(2)
            }
            .padding(.top, 40)
        }
        .frame(height: 260)
    }

    /// Minimal geometric logo mark rendered in vector form (no image asset
    /// required), matching the small diamond/arrow glyph from the reference.
    private var logoMark: some View {
        Image(systemName: "diamond.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 22, height: 22)
            .foregroundColor(.black)
    }
}

/// Organic double-wave shape for the header, matching the reference image's
/// curved bottom edge. Built entirely with relative (percentage-based)
/// control points so it scales correctly across iPhone SE through Pro Max.
/// Kept in this file, next to its only consumer, so the project has no
/// extra files beyond the original structure.
struct LoginHeaderWaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        // Flat top and sides.
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: w, y: 0))
        path.addLine(to: CGPoint(x: w, y: h * 0.78))

        // Right dip down to a mid trough.
        path.addCurve(
            to: CGPoint(x: w * 0.68, y: h * 0.92),
            control1: CGPoint(x: w * 0.90, y: h * 0.80),
            control2: CGPoint(x: w * 0.80, y: h * 0.92)
        )

        // Rise into the middle crest (where the logo sits above).
        path.addCurve(
            to: CGPoint(x: w * 0.32, y: h * 0.92),
            control1: CGPoint(x: w * 0.56, y: h * 0.92),
            control2: CGPoint(x: w * 0.44, y: h * 0.92)
        )

        // Dip back down on the left side.
        path.addCurve(
            to: CGPoint(x: 0, y: h * 0.78),
            control1: CGPoint(x: w * 0.20, y: h * 0.92),
            control2: CGPoint(x: w * 0.10, y: h * 0.80)
        )

        path.closeSubpath()
        return path
    }
}

#Preview {
    LoginHeaderView()
        .background(AppTheme.background)
}
