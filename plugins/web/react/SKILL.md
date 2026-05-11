---
name: react-context
trigger: automatic for React/Next.js projects
platform: web/react
---

# React / Next.js Context

## Project Conventions
- Framework: {{WEB_FRAMEWORK}}
- Version: {{FRAMEWORK_VERSION}}
- Rendering: {{RENDERING_STRATEGY}}
- State (global): {{STATE_MGMT}}
- State (server): {{SERVER_STATE}}
- Styling: {{STYLING}}
- TypeScript: {{USE_TYPESCRIPT}}

## Rules — React
- PREFER server components (RSC) for data fetching in Next.js App Router.
- NEVER use `useEffect` for data fetching if TanStack Query is available.
- Component size: if >200 lines, break into sub-components.
- Do not export default anonymous functions — always name them.

## Rules — Next.js App Router
- `use client` only when necessary for interactivity or browser APIs.
- Images: always use `next/image`, not `<img>`.
- Links: always use `next/link`, not `<a>`.

## DO NOT
- Add new dependencies without confirmation.
- Change `next.config.js` or `tsconfig.json` without confirmation.
