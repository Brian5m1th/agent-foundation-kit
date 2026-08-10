---
name: pm-metrics-north-star
description: Product Management skill to define the North Star Metric, build metric trees, design telemetry/analytics tracking plans, and construct data-driven A/B testing experiment plans.
---

# PM Product Metrics & Telemetry Skill

> Purpose: Formulate data strategy, define North Star Metrics, map input drivers, create telemetry tracking specifications, and design A/B testing experiments.

## Workflow

1. **North Star Metric & Metric Tree Assembly**:
   - **North Star Metric**: Identify the single metric capturing core customer value delivery and revenue alignment.
   - **Input Metrics**: Decompose North Star into 3-4 actionable drivers (e.g., Breadth/Reach, Depth/Engagement, Frequency, Efficiency).

2. **Telemetry & Tracking Spec (Event Taxonomy)**:
   - Construct telemetry tracking plan table:
     - `Event Name` (snake_case, e.g., `checkout_step_completed`).
     - `Trigger Condition` (User action / System event).
     - `Event Properties` (e.g., `user_id`, `plan_type`, `step_number`, `time_spent_sec`).

3. **Experiment & A/B Testing Design**:
   - **Hypothesis**: *"If we [Change], then [Expected Behavior], resulting in [Metric Impact] because [Rationale]"*.
   - **Metrics**: Primary KPI, Secondary Metrics, Guardrail Metrics (metrics that must NOT degrade, e.g., latency, churn).
   - **Test Design**: Control vs Variant(s), Sample Size, Run Duration, Target Confidence Level (e.g., 95%).

4. **Analytics Dashboard Specs**:
   - Define key charts and funnels needed in Amplitude / Mixpanel / PostHog / Datadog for feature monitoring post-launch.
