---
name: surgical-changes
trigger: automatic
applies_to: all
---

# Surgical Changes

In mobile projects, changing a single line in a configuration file (like `build.gradle`, `Info.plist`, or `pubspec.yaml`) can break the entire build or cause runtime crashes.

1. **Minimize Reach**: Only modify the files necessary for the task.
2. **Preserve Context**: Do not delete existing comments, formatting, or unrelated logic.
3. **Check Side Effects**: If you change a public API or a shared repository, check all call sites.
4. **Platform Specifics**:
   - **Android**: Be careful with ProGuard rules and Gradle dependencies.
   - **iOS**: Be careful with Build Phases and Plist modifications.
   - **Flutter**: Ensure version compatibility when updating packages.

Always explain *why* a change was made and what files were touched.
