//
//  AuthenticationService.swift
//  LogInPage-MVC
//
//  Created by Z.K   on 06/09/2026.
//

import Foundation

/// Abstraction over authentication so the ViewModel never talks to a
/// concrete backend directly. Swap `MockAuthenticationService` for a real
/// Firebase/REST-backed implementation later without touching the View or
/// ViewModel.
protocol AuthenticationService {
    func login(email: String, password: String) async throws
    func register(email: String, password: String) async throws
    func loginWithGoogle() async throws
    func loginWithApple() async throws
    func loginWithFacebook() async throws
}

/// Mock implementation used until a real backend is wired up. Simulates
/// network latency so the loading state in the UI can be exercised end to
/// end.
final class MockAuthenticationService: AuthenticationService {
    func login(email: String, password: String) async throws {
        try await Task.sleep(nanoseconds: 900_000_000)
    }

    func register(email: String, password: String) async throws {
        try await Task.sleep(nanoseconds: 900_000_000)
    }

    func loginWithGoogle() async throws {
        try await Task.sleep(nanoseconds: 600_000_000)
    }

    func loginWithApple() async throws {
        try await Task.sleep(nanoseconds: 600_000_000)
    }

    func loginWithFacebook() async throws {
        try await Task.sleep(nanoseconds: 600_000_000)
    }
}
