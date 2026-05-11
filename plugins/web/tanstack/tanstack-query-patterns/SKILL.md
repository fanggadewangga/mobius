---
name: tanstack-query-patterns
trigger: "fetch", "useQuery", "useMutation", "invalidate", "cache", "server state"
platform: web/tanstack
---

# TanStack Query Patterns

## Query Key Factory (Required)
```typescript
// ✅ CORRECT — define in one file, import everywhere
// queryKeys.ts
export const userKeys = {
  all: ['users'] as const,
  lists: () => [...userKeys.all, 'list'] as const,
  list: (filters: UserFilters) => [...userKeys.lists(), filters] as const,
  details: () => [...userKeys.all, 'detail'] as const,
  detail: (id: string) => [...userKeys.details(), id] as const,
}

// Usage
useQuery({ queryKey: userKeys.detail(userId), queryFn: () => fetchUser(userId) })
queryClient.invalidateQueries({ queryKey: userKeys.lists() })
```

## useMutation + Invalidation
```typescript
// ✅ CORRECT
const mutation = useMutation({
  mutationFn: (data: UpdateUserInput) => updateUser(data),
  onSuccess: () => {
    queryClient.invalidateQueries({ queryKey: userKeys.all })
  },
  onError: (error: Error) => {
    toast.error(error.message)
  },
})
```

## Do Not Duplicate State
```typescript
// ❌ WRONG — server state copied to local state
const { data } = useQuery(...)
const [user, setUser] = useState(data)  // DO NOT

// ✅ CORRECT — use data directly from useQuery
const { data: user, isLoading } = useQuery(...)
```

## staleTime for Performance
```typescript
// For data that rarely changes — set a high staleTime
useQuery({
  queryKey: ['config'],
  queryFn: fetchConfig,
  staleTime: 1000 * 60 * 10,  // 10 minutes
})
```
