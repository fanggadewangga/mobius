---
name: refactor-complex-function
trigger: "refactor", "terlalu panjang", "complex", "simplify", "clean up", "too long"
platform: mobile (android + flutter)
---

# Refactor Complex Function — Systematic Approach

## When should a function be refactored?
A function needs refactoring if it meets any of the following:
- [ ] > 30 lines (mobile) / > 20 lines (Composable/Widget).
- [ ] Has > 3 levels of nesting (if within if within for).
- [ ] Does > 1 thing (data fetch + transform + UI update in one function).
- [ ] Function name contains "And" (`fetchAndSaveAndNotify`).
- [ ] Needs many comments to explain what's happening.

## Systematic Steps

### Step 1 — Identify Responsibilities
Before refactoring, list everything the function does:
```
function `onLoginButtonClicked` does:
1. Validates email format.
2. Validates password length.
3. Shows loading indicator.
4. Calls API.
5. Saves token to SharedPreferences.
6. Navigates to HomeScreen.
7. Handles error — shows toast.
```

### Step 2 — Group by Layer
```
Validation  → move to `validateLoginInput(email, password): ValidationResult`
Loading UI  → state management (ViewModel)
API call    → Repository / UseCase
Save token  → Repository
Navigation  → Effect / callback
Error UI    → state management
```

### Step 3 — Extract in this Order
1. Extract validation to a separate function/class — safest, no side effects.
2. Extract data operations to Repository/UseCase.
3. Extract UI sub-pieces to helper Composable/Widget.
4. Leave only: orchestration (call sequence) in the main function.

### Step 4 — Verification
```bash
# Android
./gradlew test
./gradlew lint

# Flutter
flutter test
flutter analyze
```

## Flutter Refactoring Pattern (Widget)

```dart
// ❌ BEFORE — build() 80 lines
@override
Widget build(BuildContext context) {
  return Column(
    children: [
      Container(
        // ... 20 lines header
      ),
      ListView.builder(
        // ... 30 lines list
      ),
      Row(
        // ... 20 lines footer
      ),
    ],
  );
}

// ✅ AFTER — extract to private methods or Widget classes
@override
Widget build(BuildContext context) {
  return Column(
    children: [
      _buildHeader(),
      _buildProductList(),
      _buildFooter(),
    ],
  );
}

Widget _buildHeader() => Container(/* ... */);
Widget _buildProductList() => ListView.builder(/* ... */);
Widget _buildFooter() => Row(/* ... */);
```

## Android Refactoring Pattern (Kotlin)

```kotlin
// ❌ BEFORE — 60 line function
fun processOrder(order: Order) {
    // validation (15 lines)
    // price calculation (20 lines)
    // update inventory (15 lines)
    // send notification (10 lines)
}

// ✅ AFTER
fun processOrder(order: Order) {
    val validationResult = validateOrder(order)
    if (!validationResult.isValid) return handleValidationError(validationResult)

    val finalPrice = calculateFinalPrice(order)
    updateInventory(order)
    sendOrderNotification(order, finalPrice)
}

private fun validateOrder(order: Order): ValidationResult { ... }
private fun calculateFinalPrice(order: Order): Money { ... }
private fun updateInventory(order: Order) { ... }
private fun sendOrderNotification(order: Order, price: Money) { ... }
```

## Refactoring Naming Rules
- Name must describe **one** thing: `validateEmail`, not `checkEmailAndFormat`.
- For Composable: prefix `_` for private composables in the same file.
- For Kotlin: `private fun` for helpers that don't need to be exposed outside the class.
- For Flutter Widget: create a new class if the widget is used in > 1 place.

## Do NOT Refactor If
- The function is intentionally sequential and each line needs the context of the previous line.
- Tests are passing — if there are no tests, write tests before refactoring.
- Deadline is tight — record as tech debt, create a ticket, refactor in the next sprint.
