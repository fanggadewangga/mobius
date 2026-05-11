---
name: web-brainstorming
trigger: "new feature", "buat page", "buat component", "implement"
platform: web
---

# Web Feature Brainstorming

Before coding, clarify the following:

## Essential Questions
1. **Rendering strategy**: CSR / SSR / SSG / ISR? (Crucial for Next.js/Nuxt)
2. **Data fetching**: REST / GraphQL / tRPC? Server-side or client-side?
3. **Auth context**: Does this page need authentication?
4. **Route**: Is this a new page or a component on an existing page?
5. **State scope**: Local state, global state, or server state (TanStack Query)?

## Success Criteria
- [ ] Build pass (`next build` / `nuxt build` / `vite build`)
- [ ] No TypeScript errors (`tsc --noEmit`)
- [ ] No new ESLint warnings
- [ ] Unit/component tests pass
- [ ] Lighthouse score remains stable

## Web Anti-Patterns to Avoid
- DO NOT fetch data on the client if it can be done on the server (Next.js/Nuxt).
- DO NOT use `useEffect` for data fetching if TanStack Query is available.
- DO NOT use global state for server state — that's TanStack Query's job.
- DO NOT hardcode env vars — always use `.env`.
