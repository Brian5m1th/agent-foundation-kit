---
name: e2e-playwright-cypress
description: End-to-End (E2E) testing skill using Playwright or Cypress for cross-browser testing, Page Object Model (POM), visual regression, and CI execution.
---

# End-to-End (E2E) Testing Skill (Playwright & Cypress)

> Purpose: Design and automate reliable, non-flaky E2E test suites for web applications across desktop and mobile browsers.

## Core Directives

1. **Page Object Model (POM) Design**:
   - Encapsulate page locators and interaction helper methods in dedicated Page Classes (e.g., `LoginPage`, `DashboardPage`).
   - Keep test scripts clean and focused on user intentions rather than raw CSS selectors.

2. **Deterministic Waiting & Non-Flakiness**:
   - NEVER use static timers (`setTimeout`, `sleep(5000)`).
   - Use web-first assertions (`await expect(locator).toBeVisible()`, `page.waitForResponse()`).

3. **Multi-Browser & Responsive Layouts**:
   - Run tests across Chromium, Firefox, and WebKit viewports.
   - Test responsive mobile breakpoints (375x667) and desktop screens (1920x1080).

4. **Visual Regression & Screenshots**:
   - Capture baseline visual snapshots (`expect(page).toHaveScreenshot()`).
   - Automatically save screenshots and trace files upon test failure for quick debugging.
