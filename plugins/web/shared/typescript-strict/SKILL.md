---
name: typescript-strict
trigger: automatic for TypeScript projects
platform: web
---

# TypeScript Strict Mode

## Main Rules
- NEVER use `any` — use `unknown` then narrow, or define a proper type.
- NEVER use `as SomeType` to escape type errors — fix the type correctly.
- ALWAYS define return types for public functions.

## FORBIDDEN Patterns
```typescript
// ❌ WRONG
const data: any = await fetchUser()
const user = response as User
function processUser(user) { ... }  // implicit any parameter
```

## CORRECT Patterns
```typescript
// ✅ CORRECT
const data: unknown = await fetchUser()
if (isUser(data)) { /* use data as User */ }

// Type guard
function isUser(value: unknown): value is User {
  return typeof value === 'object' && value !== null && 'id' in value
}

// Explicit return type
function getDisplayName(user: User): string {
  return `${user.firstName} ${user.lastName}`
}
```

## For API Responses
```typescript
// ✅ CORRECT — validate with Zod
import { z } from 'zod'
const UserSchema = z.object({ id: z.string(), name: z.string() })
type User = z.infer<typeof UserSchema>

const parsed = UserSchema.safeParse(apiResponse)
if (parsed.success) { /* parsed.data is now type-safe */ }
```
