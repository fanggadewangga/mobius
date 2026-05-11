---
name: mobile-planning
trigger: automatic after brainstorming
---

# Mobile Planning

A good plan avoids rework. When planning a mobile feature:

1. **File Breakdown**: List every file that will be created or modified.
2. **Dependency Check**: Identify if any new dependencies are needed (ask before adding).
3. **Platform Differences**: If cross-platform (Flutter), note any platform-specific code needed.
4. **Data Contract**: Define the JSON structure or API response if not already available.
5. **UI Componentization**: Identify reusable widgets/views vs. screen-specific ones.

## Example Plan Format:
```markdown
### Files to Touch:
- `lib/data/models/user.dart` (Add field)
- `lib/presentation/pages/profile_page.dart` (Update UI)

### Logic Changes:
- Implement `fetchUserProfile` in Repository.
- Handle error state in BLoC.
```
