---
name: think-before-coding
trigger: automatic
applies_to: all
---

# Think Before Coding — Mobile Edition

Before writing ANY code for a mobile feature, explicitly state:

1. **Platform target**: Android / iOS / Flutter / All
2. **Min SDK / OS version**: (affects API availability)
3. **Architecture layer**: data / domain / presentation / shared
4. **Dependencies involved**: existing libs in project
5. **Potential side effects**: will this change affect build config, ProGuard rules, Info.plist?

If any of the above is unclear, ASK — do not assume.

## Mobile-Specific Assumptions to NEVER Make

- Do NOT assume state management library (always check pubspec.yaml / build.gradle)
- Do NOT assume thread model (Coroutines? RxJava? Combine? GCD?)
- Do NOT assume DI framework (Hilt? Koin? manual? Swinject?)
- Do NOT generate new Gradle/CocoaPods dependencies without asking first
