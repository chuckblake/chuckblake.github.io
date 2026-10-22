---
layout: page
title: Hand-building a Dark Software Factory
description: A runner I built that takes shaped issues to merged, tested code
meta_description: "How I built a dark software factory by hand: a runner that takes backlog issues from plan to merged code, and the dashboard that shows every run."
img: assets/img/projects/dark-software-factory/dashboard.png
importance: 5
category: current
published: false
---

A dark factory can run with the lights off, because nobody needs to be on the floor. I wanted to see how close one person could get to that with software.

This page shows what I built to find out. It builds my own products, and I built it by hand, one fix at a time.

## What it is

The backlog is a folder of Markdown files in my Obsidian vault, one issue per file. The vault is the database.

A runner lives on a Linux box. Every five minutes a scheduler looks for issues I have flagged and starts runs, up to three at a time. A run takes one issue to a merged pull request without me watching.

Command Center is the dashboard over all of it: the board, the queues, the live runs and the scores.

{% include figure.liquid path="assets/img/projects/dark-software-factory/system-overview.png" class="img-fluid rounded z-depth-1" zoomable=true alt="Diagram of the system: a laptop, a Linux box that runs the scheduler and the runs, the Obsidian vault that holds the backlog, and the cloud services for models and code hosting" caption="How the parts fit together. The vault holds the backlog, the Linux box runs the scheduler and the runs, and the model providers and GitHub do the rest." %}

## How a piece of work moves

**Shape.** I write the issue: a summary, acceptance criteria, what is in scope and what is not, and the decisions already made. Most of my time goes here.

**Flag.** I mark the issue ready. Nothing starts without the flag.

**Queue.** The scheduler takes flagged issues in order as run slots free up.

**Run.** A run goes through plan, plan review, an acceptance test written from the issue alone, the build, docs, the full test suite, code review and CI. A stage that fails gets up to three repair rounds before the run stops and asks.

**Merge and deploy.** When every check passes, the runner merges. Some apps deploy at the end of the run; I deploy the others.

{% include figure.liquid path="assets/img/projects/dark-software-factory/board.png" class="img-fluid rounded z-depth-1" zoomable=true alt="Kanban board with columns from Shape to Done, flags on the Todo cards that are ready for the runner, and chips naming the issue a card waits on" caption="The board. A flag means an issue is ready for the runner. A chip says what it is waiting on." %}

{% include figure.liquid path="assets/img/projects/dark-software-factory/dashboard.png" class="img-fluid rounded z-depth-1" zoomable=true alt="Command Center dashboard with the run slots in use, a slot for work done by hand, the run queue for each repository, and the live runs with time spent in their current stage" caption="The dashboard: one slot per concurrent run, one slot for work I do by hand, and the queue for each repository." %}

{% include figure.liquid path="assets/img/projects/dark-software-factory/run-detail.png" class="img-fluid rounded z-depth-1" zoomable=true alt="Issue panel for one finished run, with the issue, its outcome, and the score out of 100 broken down by part" caption="One run up close: what it was asked to do, how it turned out, and how it scored." %}

## What one week produces

In the week of October 13 to 19, 2026, the system merged 261 pull requests covering 274 issues across seven repositories.

To compare that with a developer working without AI tools, I sized each pull request from its actual changes, split into code, tests and docs, because a developer writes tests and should write docs too. I priced them at a typical pace: about 25 lines an hour of code, 50 of tests and 80 of docs, a deleted line at a fifth of a written one, plus an hour and a half per change for reading the issue, review, CI and merge.

At that pace an average change takes about 20 hours, so one developer would finish about two of these issues in a 40-hour week. The week's output comes to roughly 5,300 developer-hours, about 132 developer-weeks.

| Pace    | Hours a change | Issues a week | Developer-weeks |
| ------- | -------------- | ------------- | --------------- |
| Fast    | 13             | 3             | 84              |
| Typical | 20             | 2             | 132             |
| Careful | 33             | 1.2           | 216             |

These numbers have limits: line counts are a rough proxy, a real week holds fewer than 40 focused hours, and 69 of the pull requests built the factory itself.

## What I still do by hand

I decide what gets built, and I write the decisions into the issue before a run starts.

I answer when a run stops and asks.

{% include figure.liquid path="assets/img/projects/dark-software-factory/needs-you-phone.png" class="img-fluid rounded z-depth-1" zoomable=true max-width="390px" sizes="390px" alt="Command Center at phone width, with the Needs you card of an issue panel for a run that waits for an answer" caption="When a run needs a decision, it stops and says what it needs." %}

I finish the runs that stall, then change the runner so the same cause does not stop the next one.

I deploy the apps that do not deploy themselves, and I handle anything that needs my accounts, such as registering a CI runner.

## What I have learned

Every run gets a score out of 100 for autonomy, outcome, time to merge, repair rounds, quality and cleanup. A run I finish by hand scores low on purpose, so the scorecard records what stopped, not how well I patched it.

My first two scored runs came in at 33 and 50. After I fixed four structural causes in the runner, the next four runs averaged 94, and three of them needed nothing from me.

In an audit of 29 runs, about one in five of the 70 repairs and halts came from the issue itself: a value it did not list, a rule it did not define, a decision it left open. So I changed how I write issues.

After each run, a short retro names what stopped it and which part of the system to change.

{% include figure.liquid path="assets/img/projects/dark-software-factory/scores.png" class="img-fluid rounded z-depth-1" zoomable=true alt="Chart of run scores out of 100 over time, one point per run" caption="Every run gets a score out of 100. The low ones showed me what to fix next." %}

More on the thinking behind this: [Managing Agents is Management Again](/blog/2026/managing-agents-is-management-again/) and [Trust Is Not a Vibe](/blog/2026/trust-is-not-a-vibe/).
