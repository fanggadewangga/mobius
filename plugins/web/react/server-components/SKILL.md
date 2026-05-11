---
name: react-server-components
trigger: "rsc", "server component", "client component", "use client"
platform: web/react
---

# React Server Components (RSC)

1. **Default to Server**: Components are Server Components by default in Next.js App Router.
2. **Client Boundaries**: Use `"use client"` only for:
   - Interactivity (useState, useEffect, event listeners).
   - Browser APIs (window, localStorage).
   - Context providers.
3. **Data Fetching**: Fetch data directly in Server Components using `async/await`.
4. **Serialization**: Only serializable data can be passed from Server to Client Components.

"Move logic to the server."
