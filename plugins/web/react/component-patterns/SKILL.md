---
name: react-component-patterns
trigger: "create component", "reusable", "props", "composition"
platform: web/react
---

# React Component Patterns

## Single Responsibility
One component = one thing. If a component handles fetch + transform + render + form handling, break it down.

## Compound Components for complex UI
```tsx
// ✅ CORRECT — flexible, composable
<Card>
  <Card.Header>Title</Card.Header>
  <Card.Body>Content</Card.Body>
  <Card.Footer>Actions</Card.Footer>
</Card>

// ❌ WRONG — uncontrollable prop drilling
<Card title="Title" body="Content" footerText="Actions" showFooter={true} footerAlign="right" />
```

## Render Props / Children for flexibility
```tsx
// ✅ CORRECT
<DataTable
  data={users}
  columns={columns}
  renderEmpty={() => <EmptyState message="No users found" />}
/>
```

## Custom Hook for Logic
```tsx
// ✅ CORRECT — logic separated from component
function useUserSearch(initialQuery = '') {
  const [query, setQuery] = useState(initialQuery)
  const debouncedQuery = useDebounce(query, 300)
  const { data, isLoading } = useQuery({
    queryKey: userKeys.list({ query: debouncedQuery }),
    queryFn: () => searchUsers(debouncedQuery),
    enabled: debouncedQuery.length > 2,
  })
  return { query, setQuery, results: data, isLoading }
}
```

## Props Interface
```tsx
// ✅ CORRECT — explicit, documented
interface ButtonProps {
  /** Visual variant */
  variant?: 'primary' | 'secondary' | 'ghost'
  /** Disables interaction and shows loading spinner */
  isLoading?: boolean
  onClick?: () => void
  children: React.ReactNode
}
```
