//
//  AppTheme.swift
//  LogInPage-MVC
//
//  Created by Z.K   on 06/09/2026.
//

import SwiftUI
// MARK: - Theme
 
/// Centralized color tokens for the Login feature. Kept in this file so
/// the project doesn't need an extra file just for styling constants —
/// every component reads its colors from here instead of hardcoding values.
enum AppTheme {
    /// Very dark, near-black background used across the whole screen.
    static let background = Color(red: 0.015, green: 0.035, blue: 0.03)
 
    /// Bright neon/lime green — the primary accent used for the header,
    /// the Sign In button, and highlighted interactive text.
    static let accentGreen = Color(red: 0.70, green: 0.95, blue: 0.18)
 
    /// Dark text used on top of the green header (logo, title, subtitle).
    static let onAccentPrimary = Color.black
    static let onAccentSecondary = Color.black.opacity(0.65)
 
    /// Text colors used on the dark background.
    static let primaryText = Color.white
    static let secondaryText = Color.white.opacity(0.55)
 
    /// Input field styling.
    static let fieldBackground = Color.white.opacity(0.06)
    static let fieldIcon = Color.white.opacity(0.65)
    static let fieldPlaceholder = Color.white.opacity(0.35)
 
    /// Social button chip background.
    static let socialChipBackground = Color.white.opacity(0.08)
}
 
/// Centralized spacing tokens so layout isn't scattered with magic numbers.
enum LoginSpacing {
    static let horizontal: CGFloat = 30
    static let small: CGFloat = 8
    static let medium: CGFloat = 14
    static let large: CGFloat = 22
    static let sectionGap: CGFloat = 18
}
 
/// Centralized corner radii.
enum LoginRadius {
    static let field: CGFloat = 14
    static let button: CGFloat = 14
}
 
