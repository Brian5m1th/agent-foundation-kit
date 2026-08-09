---
name: motion-design-css
description: Micro-animations & CSS Motion Design skill (smooth keyframes, spring physics transitions, interactive feedback, scroll effects).
---

# Micro-Animations & Motion Design Skill

> Purpose: Add subtle, high-performance CSS and JS micro-animations to enhance user engagement and visual feedback.

## Motion Guidelines

1. **Performance First**:
   - Animate ONLY GPU-accelerated properties (`transform`, `opacity`). Avoid animating `height`, `width`, `margin`, or `top`/`left`.
   - Use `will-change: transform` sparingly on heavily animated elements.

2. **Easing & Durations**:
   - Fast micro-interactions (button click, hover): 150ms – 250ms with `cubic-bezier(0.4, 0, 0.2, 1)` or elastic spring `cubic-bezier(0.34, 1.56, 0.64, 1)`.
   - Modal/Drawer entries: 300ms – 400ms with ease-out.

3. **Subtle Motion Principles**:
   - Skeleton loading pulses (`@keyframes pulse`).
   - Card lift on hover (`transform: translateY(-4px)` with shadow expansion).
   - Smooth entrance animations for dynamically loaded content.
