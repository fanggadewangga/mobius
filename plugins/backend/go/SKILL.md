---
name: go-context
trigger: automatic for Go projects
platform: backend/go
---

# Go Backend Context

## Project Conventions (filled by mobius init)
- Architecture: {{GO_ARCH}}               # microservice / monolith / modular-monolith
- Service type: {{SERVICE_TYPE}}          # identity / token / transactional / gateway
- DB: {{DATABASE}}                        # postgresql / mysql / mongodb
- ORM/Query: {{DB_DRIVER}}               # sqlx / gorm / pgx / ent
- HTTP framework: {{HTTP_FRAMEWORK}}      # gin / echo / fiber / chi / net/http
- Message broker: {{MESSAGE_BROKER}}      # kafka / rabbitmq / redis-pubsub / none
- Auth: {{AUTH_TYPE}}                     # jwt / oauth2 / mtls
- DI: {{DI_PATTERN}}                     # wire / fx / manual

## Rules — Go General
- ALWAYS handle errors — never `_ = someFunc()`
- ALWAYS use context propagation — every function performing I/O must accept `ctx context.Context`
- NEVER use `init()` for business logic — only for registration
- Goroutine: ALWAYS have a shutdown mechanism (context cancel / WaitGroup)
- Logging: structured logging (zerolog / zap / slog) — not fmt.Println

## DO NOT without confirmation
- Do not change database schema
- Do not add new dependencies to go.mod
- Do not change API contracts (existing request/response structs)
- Do not change environment variable names
