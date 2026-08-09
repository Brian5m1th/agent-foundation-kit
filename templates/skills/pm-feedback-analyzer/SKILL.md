---
name: pm-feedback-analyzer
description: Product Management skill to ingest raw customer feedback, interview transcripts, support tickets, and app reviews, clustering them into Jobs-to-be-Done (JTBD), pain point severity matrices, and feature request themes.
---

# PM Feedback & Customer Voice Analyzer Skill

> Purpose: Process qualitative customer data (user interviews, CS tickets, surveys, reviews) into structured product insights, JTBD clusters, and prioritized feature recommendations.

## Workflow

1. **Data Ingestion & Cleaning**:
   - Accept raw feedback text, interview transcripts, support ticket logs, or survey responses.
   - Clean data, remove PII, and normalize categories.

2. **Categorization & Theme Clustering**:
   - Group feedback by core product themes (Usability, Performance, Missing Features, Pricing, Onboarding, Bugs).
   - Identify recurring keywords, sentiment distribution, and user cohorts.

3. **Jobs-to-be-Done (JTBD) Mapping**:
   - Extract underlying user motivations:
     - **Functional Job**: What practical task is the user trying to accomplish?
     - **Emotional Job**: How does the user want to feel during the task?
     - **Social Job**: How does the user want to be perceived by others?

4. **Pain Point Severity & Frequency Matrix**:
   - Map findings on a 2x2 Matrix: **Frequency of Mention** vs **Impact/Severity on User Journey**.
   - Highlight critical friction points ("Must Fix") vs low-hanging fruit.

5. **Actionable PM Recommendations**:
   - Synthesize findings into candidate PRD requirements, bug tickets, or product roadmap items.
   - Provide concrete quote snippets as evidence for stakeholder alignment.
