---
name: react-hooks-patterns
trigger: "hook", "use", "useState", "useEffect", "useCallback"
platform: web/react
---

# React Hooks Patterns

1. **Custom Hooks**: Extract logic into reusable custom hooks.
2. **Memoization**: Use `useMemo` and `useCallback` for expensive computations or to stabilize object references in dependency arrays.
3. **Dependency Arrays**: Be surgical; only include variables that actually change.
4. **Cleanup**: Always return a cleanup function in `useEffect` for subscriptions or timers.

"Hook into logic, not just state."
