---
name: go-improvement-review
trigger: "improvement", "optimization", "refactor", "code review", "performance review"
platform: backend/go
output: markdown report
---

# Go Service — Improvement Review Workflow

## Review Categories

### 1. Performance
- Query N+1 patterns
- Missing database indexes (check `EXPLAIN ANALYZE` for slow queries)
- Unnecessary serialization/deserialization
- Missing caching for frequently read data
- Goroutine pool vs unbounded goroutine spawn

### 2. Reliability
- Missing circuit breaker for external calls
- Missing informative health check endpoint
- Graceful shutdown implementation
- Missing dead letter queue for failed messages

### 3. Observability
- Missing distributed tracing (OpenTelemetry)
- Logs missing correlation ID / trace ID
- Missing metrics (Prometheus) for SLA monitoring
- No alerting for transaction anomalies

### 4. Maintainability
- Functions >50 lines — refactor candidate
- Package circular dependency
- Missing interface for testability
- Test coverage <70% for business logic

### 5. Scalability
- Shared mutable state becoming a bottleneck
- Missing pagination for endpoints returning lists
- Synchronous calls that could be async
- Database as a potential bottleneck (missing read replica)

## Output Format

```markdown
# Improvement Review — [Service Name]
Date: [date]

## Performance Improvements
### P-01: [Title]
**File:** `...`
**Current:** [current code]
**Improved:** [better code]
**Impact:** [estimated improvement]
**Effort:** S/M/L

## Reliability Improvements
...

## Priority Matrix
| ID | Category | Impact | Effort | Priority |
|---|---|---|---|---|
| P-01 | Performance | High | S | ⭐⭐⭐ |
```

Save to: `.mobius/reviews/[service-name]-improvement-[YYYY-MM-DD].md`
