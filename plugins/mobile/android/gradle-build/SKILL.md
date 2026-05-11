---
name: android-gradle-build
trigger: "gradle", "build.gradle", "dependencies", "sdk version"
---

# Android Gradle & Build System

1. **Version Management**: Use `libs.versions.toml` (Version Catalog) if available.
2. **Build Variants**: Understand the difference between `debug` and `release`.
3. **ProGuard/R8**: Always consider if a new library needs obfuscation rules.
4. **SDK Versions**: Respect `minSdk`. Use `@RequiresApi` if necessary.
5. **Sync**: Always sync Gradle after changes.

"Gradle is powerful but fragile. Change with care."
