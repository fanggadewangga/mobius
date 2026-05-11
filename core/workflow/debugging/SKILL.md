---
name: mobile-debugging
trigger: "bug", "fix", "crash", "error", "tidak jalan"
---

# Mobile Debugging & Root Cause Analysis

Debugging mobile apps requires looking beyond just the stack trace.

1. **RCA (Root Cause Analysis)**:
   - What is the error message?
   - In which environment does it happen? (Android vs iOS, Prod vs Dev)
   - Is it a network issue, local data issue, or UI state issue?
2. **Investigation Steps**:
   - Check logs (Logcat, Console).
   - Verify API responses.
   - Inspect local database state.
3. **The Fix**:
   - Implement a surgical fix.
   - Add a regression test to prevent it from happening again.
   - Check if this bug exists on other platforms.
