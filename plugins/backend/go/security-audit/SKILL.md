---
name: go-security-audit
trigger: "security audit", "check security", "vulnerability", "flaw", "audit",
         "race condition", "double debit", "transaction safety"
platform: backend/go
output: markdown report with severity rating
---

# Go Financial Service — Security Audit Workflow

## Output Format

All findings are formatted as Markdown with severity:
- 🔴 **CRITICAL** — can cause direct financial loss
- 🟠 **HIGH** — exploitation requires specific conditions, significant impact
- 🟡 **MEDIUM** — real risk but requires combination of conditions
- 🟢 **LOW** — best practice violation, no immediate danger

---

## CATEGORY 1: Race Condition & Concurrency

### RC-01: Double Debit / Double Credit
```go
// ❌ VULNERABLE — check-then-act without lock
func Transfer(amount decimal.Decimal) error {
    balance := repo.GetBalance(accountID)  // read
    if balance < amount { return ErrInsufficient }
    repo.Debit(accountID, amount)           // act — can race here
    return nil
}

// ✅ SAFE — SELECT FOR UPDATE + transaction
func Transfer(ctx context.Context, amount decimal.Decimal) error {
    return db.WithTransaction(ctx, func(tx *sqlx.Tx) error {
        var balance decimal.Decimal
        err := tx.QueryRowContext(ctx,
            "SELECT balance FROM accounts WHERE id=$1 FOR UPDATE NOWAIT",
            accountID,
        ).Scan(&balance)
        if balance.LessThan(amount) { return ErrInsufficient }
        _, err = tx.ExecContext(ctx,
            "UPDATE accounts SET balance=balance-$1 WHERE id=$2",
            amount, accountID,
        )
        return err
    })
}
```
**Detection:** Look for `GetBalance` pattern followed by `Debit`/`Credit` without `FOR UPDATE` or distributed lock.

---

### RC-02: Idempotency Violation (Duplicate Transaction)
```go
// ❌ VULNERABLE — same request can be processed twice
func ProcessPayment(req PaymentRequest) error {
    return repo.CreateTransaction(req)  // no idempotency check
}

// ✅ SAFE — idempotency key
func ProcessPayment(ctx context.Context, req PaymentRequest) error {
    existing, err := repo.FindByIdempotencyKey(ctx, req.IdempotencyKey)
    if err == nil { return existing, nil }  // return previous result

    return repo.CreateTransactionWithIdempotency(ctx, req)
}
```
**Detection:** Look for transfer/payment endpoints without idempotency key check. Look for `transactions` table without `idempotency_key` column with UNIQUE constraint.

---

### RC-03: TOCTOU (Time-of-Check-Time-of-Use)
```go
// ❌ VULNERABLE — state can change between check and use
exists, _ := repo.AccountExists(accountID)
if !exists { return ErrNotFound }
result, _ := repo.GetAccount(accountID)  // can be nil/error
```
**Detection:** Look for exists-check followed by get-data in two separate queries without transaction.

---

### RC-04: Goroutine Leak on Connection Pool
```go
// ❌ VULNERABLE — goroutine never stops if context cancels
go func() {
    result := <-expensiveDBCall()
    process(result)
}()

// ✅ SAFE
go func() {
    select {
    case result := <-expensiveDBCall(ctx):
        process(result)
    case <-ctx.Done():
        return
    }
}()
```
**Detection:** Look for `go func()` without `ctx.Done()` case that performs I/O.

---

### RC-05: Distributed Lock Without TTL / Expiry
```go
// ❌ VULNERABLE — if service crashes, lock is never released
redis.Set("lock:"+accountID, "1", 0)  // TTL = 0 = no expiry

// ✅ SAFE — lock with expiry
redis.SetNX("lock:"+accountID, "1", 30*time.Second)
defer redis.Del("lock:"+accountID)
```
**Detection:** Look for `redis.Set` with TTL 0 on keys containing "lock".

---

## CATEGORY 2: Database Transaction Safety

### DB-01: Missing Transaction Isolation Level
```go
// ❌ VULNERABLE — default isolation (READ COMMITTED) not enough for banking
db.Begin()

// ✅ SAFE — explicit SERIALIZABLE for financial operations
db.BeginTx(ctx, &sql.TxOptions{
    Isolation: sql.LevelSerializable,
})
```
**Detection:** Look for `db.Begin()` without `TxOptions` in functions handling transfer/payment.

---

### DB-02: Transaction Not Rolled Back on Error
```go
// ❌ VULNERABLE
tx.Exec("UPDATE accounts SET balance=balance-100 WHERE id=1")
tx.Exec("UPDATE accounts SET balance=balance+100 WHERE id=2")
tx.Commit()

// ✅ SAFE
defer func() {
    if p := recover(); p != nil {
        tx.Rollback()
    }
}()
if err := step1(tx); err != nil { return tx.Rollback() }
if err := step2(tx); err != nil { return tx.Rollback() }
return tx.Commit()
```
**Detection:** Look for functions creating `tx := db.Begin()` but missing `defer tx.Rollback()` or error check before Commit.

---

### DB-03: N+1 Query in Transactional Loop
**Detection:** Look for `for range` loop with repository call inside.

---

### DB-04: Connection Leak (Open without Close)
**Detection:** Look for `db.QueryContext` or `db.Query` not followed by `defer rows.Close()`.

---

### DB-05: Prepared Statement Injection
**Detection:** Look for `fmt.Sprintf` or string concatenation used directly in query.

---

## CATEGORY 3: Authentication & Authorization

### AA-01: JWT without Full Claims Validation
**Detection:** Look for `jwt.Parse` without `ParseWithClaims` or without explicit exp check.

---

### AA-02: Insecure Direct Object Reference (IDOR)
**Detection:** Look for handlers taking ID from path/query param but not verifying ownership with userID from token.

---

### AA-03: Token Not Invalidated on Logout / Password Change
**Detection:** Look for Logout function with no Redis/DB invalidation for JWT.

---

## CATEGORY 4: Business Logic Vulnerability

### BL-01: Negative Amount Attack
**Detection:** Look for transfer/payment functions without `amount > 0` validation.

---

### BL-02: Floating Point Precision for Financial Values
**Detection:** Look for `float64` or `float32` used to store/calculate financial values.

---

### BL-03: Transaction Limit Bypass
**Detection:** Look for limit check based only on per-transaction value without aggregate check.

---

### BL-04: Phantom Read on Balance Check
**Detection:** Look for `SELECT balance` without `FOR UPDATE` inside a transaction that performs an update later.

---

## CATEGORY 5: Infrastructure & Operational

### IO-01: Sensitive Data in Logs
**Detection:** Look for `log.*` / `fmt.*` containing fields: email, phone, cardNumber, accountNumber, password, token.

---

### IO-02: Context Timeout Not Set for External Calls
**Detection:** Look for `http.Get`, `http.Post`, `grpc.Dial` without context timeout.

---

### IO-03: Retry Without Exponential Backoff & Jitter
**Detection:** Look for `for` retry loop with `time.Sleep` fixed duration.

---

## Report Output Format

```markdown
# Security Audit Report — [Service Name]
Date: [date]
Audited by: Mobius security-audit workflow

## Executive Summary
- Total findings: X
- Critical: X | High: X | Medium: X | Low: X
- Highest risk area: [area]

## Findings

### [CRITICAL] RC-01: Double Debit Vulnerability
**File:** `internal/usecase/transfer_usecase.go:45`
**Description:** ...
**Impact:** Direct financial loss — money can be debited twice
**Reproduction:** ...
**Fix:** ...
**Effort:** [S/M/L]

---

## Summary Table
| ID | Severity | Category | File | Status |
|---|---|---|---|---|
| RC-01 | 🔴 CRITICAL | Race Condition | transfer_usecase.go:45 | Open |

## Recommendations Priority
1. [most critical item]
2. ...
```

Save to: `.mobius/security/[service-name]-audit-[YYYY-MM-DD].md`
