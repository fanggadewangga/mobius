---
name: flutter-auto-route
trigger: "navigasi", "navigate", "push", "pop", "route", "screen baru", "pindah halaman"
platform: mobile/flutter
---

# Flutter auto_route Navigation

## Project Using auto_route
DO NOT use:
- `Navigator.push()` / `Navigator.pop()`
- `Navigator.pushNamed()`
- `GoRouter`
- `context.go()` / `context.push()`

ALWAYS use auto_route patterns below.

## Navigation Patterns

### Basic Navigation
```dart
// ✅ CORRECT
context.router.push(const HomeRoute());
context.router.pop();
context.router.replace(const LoginRoute());

// ❌ WRONG — do not generate this
Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
```

### Navigation with Parameters
```dart
// ✅ CORRECT — auto_route generates type-safe params
context.router.push(ProductDetailRoute(productId: product.id));

// ❌ WRONG
Navigator.pushNamed(context, '/product', arguments: {'id': product.id});
```

### Nested / Tab Navigation
```dart
// ✅ CORRECT — use inner router for nested navigation
context.innerRouterOf<TabsRouter>(TabsRoute.name)?.setActiveIndex(1);
```

### Route Guards
```dart
// ✅ CORRECT — guard defined in AppRouter, not in screen
// Do not add auth check inside screen — put in AutoRouteGuard
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, guards: [AuthGuard]),
  ];
}
```

### Adding a New Route
1. Create a new screen file.
2. Add `@RoutePage()` annotation to the class.
3. Register in `AppRouter` — do not forget.
4. Run `flutter pub run build_runner build` to generate `.gr.dart`.
5. DO NOT edit `.gr.dart` files manually — they are generated.

## Checklist Before Submit
- [ ] No new `Navigator.push` / `pushNamed`.
- [ ] New route registered in AppRouter.
- [ ] `build_runner` has been executed.
- [ ] `.gr.dart` file is updated (not manually edited).
