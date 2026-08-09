---
name: sonarqube-static-analysis
description: SonarQube & static code analysis skill for detecting code smells, cognitive complexity limits, security hotspots, vulnerabilities, and coverage gates.
---

# SonarQube & Static Analysis Skill

> Purpose: Audit codebase against SonarQube quality gates, security vulnerabilities (OWASP), cognitive complexity metrics, and code smell thresholds.

## Audit Checklist & Metrics

1. **Cognitive Complexity**:
   - Flag any function/method with Cognitive Complexity > 15.
   - Refactor deeply nested loops, conditionals, and switch statements into smaller single-responsibility functions.

2. **Duplicated Code & Code Smells**:
   - Detect duplicated code blocks (> 3% duplication threshold).
   - Identify maintainability code smells (unused variables, dead code, commented-out blocks, magic numbers).

3. **Security Hotspots & Vulnerabilities (OWASP / Snyk / Sonar)**:
   - Audit for SQL Injection, XSS, CSRF, insecure Deserialization, and Hardcoded Secrets.
   - Verify proper input validation, password hashing, and CORS headers.

4. **Quality Gate Compliance**:
   - New Code Coverage >= 80%.
   - Zero Blocked or Critical Security Vulnerabilities.
   - Zero Security Hotspots unreviewed.
   - Maintainability Rating: **A**.
