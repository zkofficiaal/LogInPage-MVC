//
//  LoginModel.swift
//  LogInPage-MVC
//
//  Created by Z.K   on 06/09/2026.
//

import SwiftUI
 
// MARK: - Model
 
/// Simple value type representing the credentials the user is entering.
/// Kept intentionally minimal — validation and state live in the ViewModel.
struct LoginModel {
    var email: String
    var password: String
}
