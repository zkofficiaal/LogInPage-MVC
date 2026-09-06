//
//  LoginPasswordField.swift
//  LogInPage-MVC
//
//  Created by Z.K   on 06/09/2026.
//

import SwiftUI

/// Reusable "label + icon + secure field + eye toggle" component.
/// Used for both the Password field and (in registration mode) the
/// Confirm Password field — each instance manages its own show/hide state.
struct LoginPasswordField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var isFocused: FocusState<LoginView.Field?>.Binding
    let field: LoginView.Field
    var submitLabel: SubmitLabel = .next
    var onSubmit: () -> Void = {}

    /// Optional trailing accessory shown to the right of the label
    /// (used for "Forgot Password?" next to the Password label row).
    var trailingAccessory: AnyView? = nil

    @State private var isSecure: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: LoginSpacing.small) {
            HStack {
                Text(label)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(AppTheme.primaryText)

                Spacer()

                if let trailingAccessory {
                    trailingAccessory
                }
            }

            HStack(spacing: 10) {
                Image(systemName: "lock.fill")
                    .foregroundColor(AppTheme.fieldIcon)
                    .frame(width: 18)

                Group {
                    if isSecure {
                        SecureField("", text: $text, prompt: Text(placeholder)
                            .foregroundColor(AppTheme.fieldPlaceholder))
                    } else {
                        TextField("", text: $text, prompt: Text(placeholder)
                            .foregroundColor(AppTheme.fieldPlaceholder))
                    }
                }
                .foregroundColor(AppTheme.primaryText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .focused(isFocused, equals: field)
                .submitLabel(submitLabel)
                .onSubmit(onSubmit)
                .accessibilityLabel(label)

                Button {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        isSecure.toggle()
                    }
                } label: {
                    Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(AppTheme.fieldIcon)
                }
                .accessibilityLabel(isSecure ? "Show password" : "Hide password")
            }
            .padding(.horizontal, 14)
            .frame(height: 50)
            .background(AppTheme.fieldBackground)
            .clipShape(RoundedRectangle(cornerRadius: LoginRadius.field))
        }
    }
}
