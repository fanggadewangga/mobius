---
name: react-state-management
trigger: "state", "zustand", "jotai", "redux", "context"
platform: web/react
---

# React State Management

1. **Zustand**: Preferred for global state. Minimalistic and external to React.
2. **Jotai**: Use for atomic state management.
3. **Context API**: Use only for low-frequency updates (e.g., Theme, Auth user).
4. **Server State**: DO NOT store server data in global state; use TanStack Query.

"State should be as local as possible."
