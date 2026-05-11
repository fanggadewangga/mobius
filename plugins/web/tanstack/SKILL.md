---
name: tanstack-context
trigger: automatic when @tanstack/* detected
platform: web/tanstack
---

# TanStack Context

## Detected Packages
- TanStack Query: {{HAS_TANSTACK_QUERY}}
- TanStack Router: {{HAS_TANSTACK_ROUTER}}
- TanStack Form: {{HAS_TANSTACK_FORM}}
- TanStack Table: {{HAS_TANSTACK_TABLE}}

## TanStack Query Rules
- NEVER use local state + `useEffect` for server data — use `useQuery` or `useMutation`.
- Query keys must be consistent and centralized (Query Key Factory pattern).
- Invalidation: always invalidate relevant queries after a mutation.
- Error handling: use `onError` in `useMutation`.

## TanStack Router Rules
- Type-safe routes: ALWAYS define route types; do not use `as string` for params.
- Loaders: use route loaders for data needed on page load.
- Search params: use `validateSearch` for type-safe query params.

## TanStack Form Rules
- Validation: define in schema (Zod/Valibot), not inline.
- Submission: use `form.handleSubmit`.

## TanStack Table Rules
- Column definitions: define outside the component to avoid re-renders.
- Server-side: use `manualPagination` and `manualSorting` for large datasets.
