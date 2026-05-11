---
name: web-review
trigger: "review", "ready", "finish", "commit"
platform: web
---

# Web Code Review

1. **RSC vs Client Components**: Ensure `use client` is used only where necessary.
2. **Performance**: Check for heavy dependencies and unnecessary re-renders.
3. **Accessibility**: Verify ARIA roles, labels, and keyboard navigation.
4. **Security**: Ensure data is sanitized and no secrets are exposed in the client bundle.

"Quality is everyone's responsibility."
