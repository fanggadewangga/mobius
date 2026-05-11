---
name: tanstack-form-patterns
trigger: "useForm", "field", "validate"
platform: web/tanstack
---

# TanStack Form Patterns

1. **Atomic Fields**: Use the `<form.Field>` component for granular control.
2. **Schema Integration**: Plug in Zod or Valibot for robust validation.
3. **Form State**: Access `form.state` for dirty, touched, and error statuses.
4. **Asynchronous Validation**: Use async functions for server-side checks (e.g., username availability).

"Headless, type-safe forms."
