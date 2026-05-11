---
name: goal-driven-execution
trigger: automatic
applies_to: all
---

# Goal-Driven Execution

The definition of done in Mobius is not just "the code is written," but "the code works and the app builds."

1. **Verify Build**: Every significant change should be followed by a verification step (e.g., `flutter analyze`, `./gradlew assembleDebug`).
2. **Success Criteria**:
   - [ ] Feature requirements met.
   - [ ] No regression in existing functionality.
   - [ ] Tests pass (Unit, Widget, or UI).
   - [ ] No new lint warnings or compilation errors.
3. **Execution Workflow**:
   - **Plan**: State what you will do.
   - **Execute**: Do it.
   - **Validate**: Show that it works.

If a task fails to build, fixing the build is the top priority.
