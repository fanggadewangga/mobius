---
name: tanstack-query-patterns
trigger: "useQuery", "useMutation", "queryKey", "invalidateQueries"
platform: web/tanstack
---

# TanStack Query Patterns

1. **Query Key Factory**: Centralize query keys to avoid typos and hardcoding.
2. **Infinite Queries**: Use `useInfiniteQuery` for lists with pagination.
3. **Optimistic Updates**: Use `onMutate` to update the cache before the server responds.
4. **Prefetching**: Use `queryClient.prefetchQuery` for smoother transitions.

"Server state management for the web."
