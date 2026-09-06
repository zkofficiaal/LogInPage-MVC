//
//  LoginController.swift
//  LogInPage-MVC
//
//  Created by Z.K   on 06/09/2026.
//

import Combine
import SwiftUI

/// The Controller in this MVC structure: owns all form state, validation,
/// and authentication actions, and mediates between the Model
/// (LoginModel/AuthenticationService) and the Views. Views never validate
/// or call the auth service directly — they only read published state and
/// forward user actions here.
@MainActor
final class LoginController: ObservableObject {

    // MARK: - Form state

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    // MARK: - Mode

    /// false = Login mode (Email, Password, Forgot Password, Sign In)
    /// true  = Registration mode (Email, Password, Confirm Password, Create Account)
    @Published var isCreateAccountMode: Bool = false

    // MARK: - UI state

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showError: Bool = false

    @Published var showForgotPasswordSheet: Bool = false
    @Published var showPrivacySheet: Bool = false
    @Published var showTermsSheet: Bool = false

    private let authService: AuthenticationService

    init(authService: AuthenticationService = MockAuthenticationService()) {
        self.authService = authService
    }

    // MARK: - Validation

    private func isValidEmail(_ email: String) -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return email.range(of: regex, options: .regularExpression) != nil
    }

    private func validateLogin() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Please enter your email address."
        }
        if !isValidEmail(email) {
            return "Please enter a valid email address."
        }
        if password.isEmpty {
            return "Please enter your password."
        }
        if password.count < 6 {
            return "Password must be at least 6 characters."
        }
        return nil
    }

    private func validateRegistration() -> String? {
        if let baseError = validateLogin() {
            return baseError
        }
        if confirmPassword.isEmpty {
            return "Please confirm your password."
        }
        if confirmPassword != password {
            return "Passwords do not match."
        }
        return nil
    }

    // MARK: - Actions — Login

    func signIn() {
        if let validationError = validateLogin() {
            present(error: validationError)
            return
        }

        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                try await authService.login(email: email, password: password)
            } catch {
                present(error: "Unable to sign in. Please try again.")
            }
        }
    }

    // MARK: - Actions — Registration

    /// Tapping "Create Account" switches the form into registration mode.
    /// It does NOT submit anything by itself.
    func createAccount() {
        withAnimation(.easeInOut(duration: 0.2)) {
            isCreateAccountMode = true
        }
    }

    /// Submits the registration form (bound to the primary button while
    /// `isCreateAccountMode` is true).
    func submitRegistration() {
        if let validationError = validateRegistration() {
            present(error: validationError)
            return
        }

        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                try await authService.register(email: email, password: password)
            } catch {
                present(error: "Unable to create your account. Please try again.")
            }
        }
    }

    /// Returns from registration mode back to the standard login form.
    func returnToLogin() {
        withAnimation(.easeInOut(duration: 0.2)) {
            isCreateAccountMode = false
        }
        confirmPassword = ""
        errorMessage = nil
        showError = false
    }

    // MARK: - Actions — Forgot password

    func forgotPassword() {
        showForgotPasswordSheet = true
    }

    // MARK: - Actions — Social

    func signInWithGoogle() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                try await authService.loginWithGoogle()
            } catch {
                present(error: "Google sign-in failed. Please try again.")
            }
        }
    }

    func signInWithApple() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                try await authService.loginWithApple()
            } catch {
                present(error: "Apple sign-in failed. Please try again.")
            }
        }
    }

    func signInWithFacebook() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                try await authService.loginWithFacebook()
            } catch {
                present(error: "Facebook sign-in failed. Please try again.")
            }
        }
    }

    // MARK: - Actions — Footer

    func openPrivacy() {
        showPrivacySheet = true
    }

    func openTerms() {
        showTermsSheet = true
    }

    // MARK: - Helpers

    private func present(error message: String) {
        errorMessage = message
        showError = true
    }
}
