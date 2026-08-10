---
name: web-mcp-e2e-tester
description: Automated web app auditing and E2E testing skill using Chrome DevTools MCP or Playwright MCP (console errors, network failures, visual screenshots, Lighthouse).
---

# Web & E2E Testing Skill via Chrome DevTools / Playwright MCP

> Purpose: Perform autonomous E2E testing, visual inspection, console error detection, and network auditing on live web applications using Chrome DevTools or Playwright MCP servers.

## Audit Workflow

### Step 1: Page Navigation & Setup
- Use `navigate_page` to open the target URL (e.g., `http://localhost:3000` or production URL).
- Set viewport size using `resize_page` or `emulate` for mobile/desktop testing.

### Step 2: Console & Network Monitoring (Runtime Bug Hunting)
- **Console Errors**: Call `list_console_messages` to capture JavaScript exceptions, unhandled promise rejections, and runtime warnings.
- **Network Failures**: Call `list_network_requests` to inspect failed API endpoints (HTTP status 4xx/5xx), slow network requests, or CORS errors.

### Step 3: Interactive UI Testing & Form Flows
- Use `fill_form` or `type_text` to fill input fields with test data (valid, invalid, boundary).
- Use `click` to trigger form submissions, modal dialogs, and navigation buttons.
- Use `wait_for` or snapshot checks to ensure DOM elements render properly.

### Step 4: Visual & Accessibility Verification
- Use `take_screenshot` to capture visual snapshots of key UI states (loading, error, success, responsive mobile layout).
- Use `lighthouse_audit` to run automated performance, accessibility (WCAG), and SEO evaluations.

### Step 5: Bug Report Generation
Generate an actionable bug report containing:
1. **Runtime Exceptions**: Exact JS console stack traces.
2. **Network Failures**: API endpoint, HTTP status code, and response body error.
3. **Visual Regressions**: Attached screenshot reference.
4. **Steps to Reproduce**: Exact sequence of click/fill actions.
