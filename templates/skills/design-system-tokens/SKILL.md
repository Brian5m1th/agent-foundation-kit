---
name: design-system-tokens
description: Design System & Design Tokens skill (DESIGN.md, HSL color palettes, fluid typography, spacing scales, CSS variables, anti-AI-slop guidelines).
---

# Design System & Tokens Skill (`DESIGN.md`)

> Purpose: Establish, maintain, and enforce cohesive design systems using design tokens and a project-level `DESIGN.md` to prevent generic AI design "slop".

## Core Principles

1. **Design Tokens as Source of Truth**:
   - Define all visual primitives as CSS variables (`:root` tokens):
     - **Colors**: Use HSL tailored scales (`--primary-hsl: 220 90% 56%`, `--bg-dark-hsl: 222 47% 11%`).
     - **Typography**: Fluid type scale using `clamp()` (`--font-lg: clamp(1.25rem, 2vw + 1rem, 2rem)`).
     - **Spacing**: Consistent 4px/8px grid scale (`--space-1: 0.25rem`, `--space-4: 1rem`).
     - **Radii & Shadows**: Harmonious border radii (`--radius-md: 0.5rem`) and soft ambient elevation shadows (`--shadow-lg`).

2. **`DESIGN.md` Architecture**:
   - Create or update `DESIGN.md` in the root workspace to document visual rationale, contrast rules, component anatomy, and dark/light mode rules.

3. **Anti-AI-Design-Slop Rules**:
   - NO plain primary colors (plain `#ff0000`, `#0000ff`). Use curated HSL palettes.
   - NO browser default fonts. Require modern typography (Inter, Roboto, Outfit, Plus Jakarta Sans).
   - Require clean visual hierarchy: distinct heading sizes, subtle muted text (`color-mix` or HSL opacity), and prominent call-to-action buttons.
