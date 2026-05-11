---
name: android-no-hardcoded-strings
trigger: automatic (always active for Android projects)
platform: mobile/android
---

# Android — No Hardcoded Strings

## Main Rule
NEVER hardcode user-visible strings. ALWAYS use `strings.xml` resources.

## FORBIDDEN Patterns

```kotlin
// ❌ WRONG — Compose
Text("Welcome")
Button(onClick = {}) { Text("Login") }
Toast.makeText(context, "An error occurred", Toast.LENGTH_SHORT).show()
Snackbar.make(view, "Data saved successfully", Snackbar.LENGTH_SHORT).show()

// ❌ WRONG — XML layout
android:text="Welcome"
android:hint="Enter email"
```

## CORRECT Patterns

```kotlin
// ✅ CORRECT — Compose
Text(stringResource(R.string.welcome_message))
Button(onClick = {}) { Text(stringResource(R.string.btn_login)) }
Toast.makeText(context, getString(R.string.error_generic), Toast.LENGTH_SHORT).show()

// ✅ CORRECT — ViewModel / non-UI layer
// Use UiText sealed class to pass strings to UI
sealed class UiText {
    data class DynamicString(val value: String) : UiText()
    class StringResource(
        @StringRes val resId: Int,
        vararg val args: Any
    ) : UiText()
}
```

```xml
<!-- ✅ CORRECT — XML layout -->
android:text="@string/welcome_message"
android:hint="@string/hint_email"
```

## strings.xml Naming Conventions
```xml
<!-- Screens: [screen]_[element]_[description] -->
<string name="login_title">Log In</string>
<string name="login_btn_submit">Login</string>
<string name="login_hint_email">Enter email</string>

<!-- Common/shared -->
<string name="common_btn_save">Save</string>
<string name="common_btn_cancel">Cancel</string>
<string name="error_generic">An error occurred. Please try again.</string>
<string name="error_network">No internet connection.</string>
```

## Allowed Exceptions
```kotlin
// ✅ OK — string for developer/debug (not user-visible)
Log.d("TAG", "onResume called")
throw IllegalStateException("ViewModel must be initialized")

// ✅ OK — truly dynamic content description
contentDescription = product.name  // product name from server
```

## Checklist
- [ ] No string literals in Composable / XML layout (except `@` resource ref).
- [ ] Toast / Snackbar use `R.string.*`.
- [ ] New strings added to `strings.xml` (and `strings-en.xml` if i18n exists).
