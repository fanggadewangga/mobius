---
name: microservice-architecture
trigger: "microservice", "arsitektur", "structure", "folder structure"
platform: backend/go
---

# Go Microservice Architecture Patterns

## 1. Clean Architecture / Hexagonal
Structure the project to isolate business logic from infrastructure.
- `cmd/`: Application entry points.
- `internal/domain/`: Pure business objects and logic.
- `internal/usecase/`: Orchestrates domain logic (Business Rules).
- `internal/repository/`: Data persistence implementations.
- `internal/handler/`: HTTP/gRPC handlers.
- `pkg/`: Shared utilities.

## 2. API Gateway & mTLS
- Use an API Gateway (Kong, Traefik) for public entry points.
- Use mTLS for service-to-service communication.

## 3. Distributed Tracing & Observability
- Integrate OpenTelemetry.
- Use Correlation IDs to trace requests across services.
- Structured logging with `zap` or `zerolog`.

## 4. Resilience Patterns
- Circuit Breakers (gobreaker).
- Retries with Exponential Backoff and Jitter.
- Timeouts on all external calls.

## 5. Event-Driven Communication
- Use message brokers (Kafka, RabbitMQ) for async tasks.
- Implement the Outbox Pattern for reliable event publishing.
