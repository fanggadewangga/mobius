---
name: web-performance
trigger: "optimize", "lambat", "slow", "lighthouse", "bundle", "LCP", "FCP"
platform: web
---

# Web Performance Skill

## Core Metrics
- LCP < 2.5s
- FID / INP < 200ms
- CLS < 0.1

## Optimization Checklist
1. **Bundle Size**: Use dynamic imports and tree-shaking.
2. **Rendering**: Avoid frequent re-renders; use `useMemo`/`useCallback` or Vue's `computed`.
3. **Data Fetching**: Use TanStack Query caching and parallelize requests.
4. **Images**: Use `next/image` (Next.js) or modern formats like WebP/AVIF.

"Speed is a feature."
