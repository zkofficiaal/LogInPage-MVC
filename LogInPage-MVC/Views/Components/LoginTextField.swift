//
//  LoginTextField.swift
//  LogInPage-MVC
//
//  Created by Z.K   on 06/09/2026.
//

import SwiftUI

/// Reusable "label + icon field" used for the Email input.
struct LoginTextField: View {
    let label: String
    let placeholder: String
    let systemIcon: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    var isFocused: FocusState<LoginView.Field?>.Binding
    let field: LoginView.Field
    var onSubmit: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: LoginSpacing.small) {
            Text(label)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(AppTheme.primaryText)

            HStack(spacing: 10) {
                Image(systemName: systemIcon)
                    .foregroundColor(AppTheme.fieldIcon)
                    .frame(width: 18)

                TextField("", text: $text, prompt: Text(placeholder)
                    .foregroundColor(AppTheme.fieldPlaceholder))
                    .foregroundColor(AppTheme.primaryText)
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textContentType(textContentType)
                    .focused(isFocused, equals: field)
                    .submitLabel(.next)
                    .onSubmit(onSubmit)
                    .accessibilityLabel(label)
            }
            .padding(.horizontal, 14)
            .frame(height: 50)
            .background(AppTheme.fieldBackground)
            .clipShape(RoundedRectangle(cornerRadius: LoginRadius.field))
        }
    }
}
