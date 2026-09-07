<img width="381" height="773" alt="Screenshot 2026-09-07 at 10 52 10 AM" src="https://github.com/user-attachments/assets/a98720df-4845-48b2-bf51-ad8b1c2e9249" />
<img width="389" height="780" alt="Screenshot 2026-09-07 at 10 51 53 AM" src="https://github.com/user-attachments/assets/e9f2892f-23ab-459c-8a86-84207fbb3305" />

# LoginFeature (MVC)

A SwiftUI login/registration screen built with MVC, matching a neon-green
fintech-style reference design. Includes a custom wave-shaped header, full
field validation, mock authentication, and a Create Account flow.

## Structure

```
LoginFeature/
│
├── Models/
│   └── LoginModel.swift          # Email/password value type, theme + spacing tokens
│
├── Controllers/
│   └── LoginController.swift     # All state, validation, and auth actions
│
├── Views/
│   ├── LoginView.swift           # Screen composition + keyboard/focus handling
│   └── Components/
│       ├── LoginHeaderView.swift        # Wave header, logo, title, subtitle
│       ├── LoginTextField.swift         # Reusable icon + text field (Email)
│       ├── LoginPasswordField.swift     # Reusable icon + secure field with eye toggle
│       ├── SocialLoginButton.swift      # Google / Apple / Facebook chip
│       ├── LoginDividerView.swift       # "OR CONTINUE WITH" divider
│       └── LoginFooterView.swift        # Privacy / Terms links
│
└── Services/
    └── AuthenticationService.swift  # Protocol + MockAuthenticationService
```

## How it works

- **MVC boundaries.** `LoginView` never validates or calls auth directly —
  every action (`signIn()`, `createAccount()`, `signInWithGoogle()`, etc.)
  lives on `LoginController`. The View only reads `@Published` state and
  forwards taps to the Controller, which is the sole mediator between the
  View and the Model/Service layer.
- **Two modes, one screen.** `LoginController.isCreateAccountMode` toggles
  between:
  - **Login:** Email, Password, Forgot Password, Sign In, social buttons,
    "Create Account" link.
  - **Registration:** Email, Password, Confirm Password, Create Account
    button, "Sign In" link back to login. The Confirm Password field
    animates in/out and only exists in this mode.
- **Validation** lives entirely in the Controller: email format, password
  length, and (in registration mode) that Confirm Password matches. Errors
  surface through a single `errorMessage` / `showError` pair, shown as an
  alert.
- **Auth service** is a protocol (`AuthenticationService`) with a
  `MockAuthenticationService` that simulates network latency. Swap in a
  real implementation later without touching the View or Controller.
- **Focus & keyboard.** `LoginView.Field` (`.email`, `.password`,
  `.confirmPassword`) drives `@FocusState`, so Return/Next moves between
  fields correctly in both modes, and the form sits in a `ScrollView` so
  the primary button never gets stuck behind the keyboard.
- **Theming.** `AppTheme`, `LoginSpacing`, and `LoginRadius` live at the
  top of `LoginModel.swift` — one place for every color, spacing, and
  corner-radius value, with no extra files beyond the structure above.

## Integration

Add the folder to your Xcode project, then launch the screen from your
app's entry point:

```swift
import SwiftUI

@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
```

## Requirements

- iOS 17+
- Swift / SwiftUI only — no third-party dependencies

## Extending

- Replace `MockAuthenticationService` with a real implementation of
  `AuthenticationService` (Firebase, your own REST API, etc.) — no other
  file needs to change.
- Wire `showForgotPasswordSheet`, `showPrivacySheet`, and `showTermsSheet`
  in `LoginView` to real content; they currently open placeholder sheets.
  
## Designed and Developed by M.Zahid Khan iOS Developer 
