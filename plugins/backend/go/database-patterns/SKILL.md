---
name: go-database-patterns
trigger: "database", "transaction", "sql", "repository", "query"
platform: backend/go
---

# Go Database Best Practices

## 1. Transaction Management
Always use transactions for multi-step updates. Use `sql.LevelSerializable` for financial transactions.

```go
tx, err := db.BeginTx(ctx, &sql.TxOptions{Isolation: sql.LevelSerializable})
if err != nil {
    return err
}
defer tx.Rollback() // Safe to call even if committed

// ... execute queries using tx ...

return tx.Commit()
```

## 2. Parameterized Queries
Never use `fmt.Sprintf` to build queries. Always use placeholders (`?` or `$1`).

## 3. Handling Nulls
Use `sql.NullString`, `sql.NullInt64`, etc., or pointer types in structs to handle nullable columns.

## 4. Connection Management
- Use `db.SetMaxOpenConns`, `db.SetMaxIdleConns`, and `db.SetConnMaxLifetime`.
- Always close `rows` using `defer rows.Close()`.

## 5. Repository Pattern
Isolate database logic in repository layers. Use interfaces to allow mocking in tests.

## 6. Optimization
- Use indexes for frequently queried columns.
- Use `EXPLAIN ANALYZE` to debug slow queries.
- Avoid N+1 queries by using `IN` clauses or joins.
