---
name: vue-pinia
trigger: "pinia", "store", "defineStore"
platform: web/vue
---

# Pinia State Management

1. **Define Store**: Use `defineStore` with the Setup Store pattern (using `ref` and `computed`).
2. **Modular Stores**: Split stores by domain (e.g., `useAuthStore`, `useCartStore`).
3. **Actions**: Keep business logic inside store actions.
4. **Getters**: Use computed properties for store state selection.

"The intuitive store for Vue."
