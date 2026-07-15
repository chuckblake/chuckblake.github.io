---
layout: page
title: Glance
description: Expectation monitoring for automated work — built in Rails, running in production
img: assets/img/projects/glance.jpg
importance: 2
category: current
---

[Glance](https://glnc.io) is an expectation monitoring platform for automated work and AI-run operations.

It answers the operational question that uptime dashboards and issue trackers usually miss: did the thing that was supposed to happen actually happen? Glance lets teams define expectations for jobs, agents, queues, and business signals, then watches for silent failures like missed check-ins, low-output runs, stalled agents, or pipelines that quietly run dry.

**What Glance does now:**

- Tracks scheduled jobs and external automations through API-backed run reporting
- Computes green/yellow/red status from cadence, failures, duration, and output expectations
- Checks run metadata, such as whether an import produced enough records to count as healthy
- Sends alerts and daily digests while supporting mute/disable/throttle controls
- Connects failures to remediation work items so humans or agents can investigate and fix the problem

The original agent-first work queue is still part of the product, but it has become the response loop: when reality stops matching expectations, Glance opens the work needed to bring the system back into shape.

{% include figure.liquid loading="eager" path="assets/img/projects/glance.jpg" class="img-fluid rounded z-depth-1 mt-4" alt="Glance expectation monitoring dashboard" %}
