---
name: vue-context
trigger: automatic for Vue/Nuxt projects
platform: web/vue
---

# Vue / Nuxt Context

## Project Conventions
- Framework: {{WEB_FRAMEWORK}}
- Vue version: {{VUE_VERSION}}
- State: {{STATE_MGMT}}
- Composition API: {{USE_COMPOSITION}}
- TypeScript: {{USE_TYPESCRIPT}}
- Styling: {{STYLING}}

## Rules
- ALWAYS use Composition API + `<script setup>` — not Options API.
- State: Pinia for global state, `ref/reactive` for local state.
- Composables: one concern per composable (e.g., `useAuth`, `useProducts`).
- Nuxt: use `useFetch` / `useAsyncData` for server-side data fetching.

## DO NOT
- Mix Options API and Composition API in the same file.
- Fetch in `mounted()` if it can be done in `useAsyncData` (Nuxt).
