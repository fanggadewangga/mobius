---
name: flutter-pub-dependencies
trigger: "pubspec", "package", "dependency", "library"
---

# Flutter Dependencies Management

1. **Ask Before Adding**: Never add a new package to `pubspec.yaml` without developer approval.
2. **Version Pinning**: Use compatible versions (e.g., `^1.0.0`) and avoid `any`.
3. **Dev Dependencies**: Put testing and generator tools in `dev_dependencies`.
4. **Resolution**: Always run `flutter pub get` after changing `pubspec.yaml`.
5. **Quality Check**: Prefer official packages (from `flutter.dev` or `dart.dev`) or well-maintained community ones.

"Every dependency is a liability. Keep it lean."
