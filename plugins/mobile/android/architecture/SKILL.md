---
name: android-architecture
trigger: "mvvm", "mvi", "clean arch", "layer"
---

# Android Architecture

1. **MVVM (Model-View-ViewModel)**: The standard pattern. View (Activity/Fragment) observes ViewModel.
2. **Repository Pattern**: Abstract data sources (Local, Remote).
3. **Usecases**: Optional layer for complex business logic.
4. **Data Binding / View Binding**: Use ViewBinding for XML layouts.
5. **Dependency Injection**: Use Hilt (recommended) or Koin.

"Layers keep the complexity under control."
