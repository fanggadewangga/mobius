---
name: go-concurrency-patterns
trigger: "goroutine", "concurrency", "channel", "race condition", "mutex", "waitgroup"
platform: backend/go
---

# Go Concurrency Best Practices

## 1. Respect Context
Every goroutine that performs I/O or long-running tasks MUST respect `context.Context`.

```go
go func() {
    for {
        select {
        case <-ctx.Done():
            return
        default:
            // do work
        }
    }
}()
```

## 2. Channels for Communication, Mutex for State
- Use channels to pass ownership of data.
- Use `sync.Mutex` or `sync.RWMutex` to protect shared state.
- Avoid nesting mutexes to prevent deadlocks.

## 3. WaitGroups for Synchronization
Use `sync.WaitGroup` to wait for a collection of goroutines to finish.

```go
var wg sync.WaitGroup
for i := 0; i < 10; i++ {
    wg.Add(1)
    go func() {
        defer wg.Done()
        // do work
    }()
}
wg.Wait()
```

## 4. Avoid Goroutine Leaks
Ensure every goroutine has a clear exit condition. Never start a goroutine without knowing how it will stop.

## 5. Use `errgroup` for Complex Tasks
Use `golang.org/x/sync/errgroup` to manage multiple goroutines where you need to collect the first error.
