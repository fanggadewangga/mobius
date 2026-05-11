---
name: vue-composables
trigger: "composable", "use", "ref", "computed"
platform: web/vue
---

# Vue Composables Patterns

1. **State Injection**: Use `ref` and `reactive` for encapsulated state.
2. **Lifecycle Hooks**: Use `onMounted`, `onUnmounted` inside composables to manage side effects.
3. **Computed Values**: Use `computed` for derived state to ensure reactivity.
4. **Naming**: Prefix composables with `use` (e.g., `useUser`).

"Encapsulate and reuse."
