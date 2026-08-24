---
name: api-contract-testing
description: API and contract testing skill for REST, GraphQL, OpenAPI schemas, DB integration, and mock servers.
---

# API & Contract Testing Skill

> Purpose: Validate API endpoints, payload contracts, database interactions, and integration boundaries.

## Testing Protocol

1. **Schema & Contract Validation**:
   - Verify HTTP responses match exact OpenAPI 3.0 / JSON Schema specifications.
   - Audit required headers (`Content-Type: application/json`, `Authorization`).
   - Validate status codes (200 OK, 201 Created, 400 Bad Request, 401 Unauthorized, 404 Not Found, 422 Unprocessable Entity, 500 Internal Error).

2. **Integration & Database Verification**:
   - Test full request-response lifecycle against test database containers (Testcontainers/SQLite memory).
   - Ensure transactions roll back cleanly after test execution.

3. **GraphQL & RPC Protocols**:
   - Validate GraphQL query/mutation schemas, error arrays, and data nullability.
