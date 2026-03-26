---
layout: page
title: Glance
description: Agent-first work queue and issue tracker
img: 
importance: 4
category: current
---

[Glance](https://glnc.io) is a lightweight, agent-first work queue and issue tracker designed for teams building with AI.

Most issue trackers were built for humans — Glance is built for the way modern teams actually work: with agents doing research, writing code, and shipping features alongside (or instead of) humans.

**What makes it agent-first:**
- Work queue as the core primitive — not boards, not sprints
- Token-efficient context: agents get exactly what they need, nothing they don't
- State machine model for tasks — agents can claim, lock, and close work programmatically
- ICE scoring (Impact, Confidence, Effort) baked in as a queryable API
- Dependency graph: agents understand what's blocked and what's ready

Built out of frustration with tools that assume a human is always at the keyboard.

{% include figure.liquid loading="eager" path="assets/img/projects/glance.jpg" class="img-fluid rounded z-depth-1 mt-4" alt="Glance work queue" %}
