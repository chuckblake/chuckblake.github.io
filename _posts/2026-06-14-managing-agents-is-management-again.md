---
layout: post
title: Managing Agents is Management Again
date: 2026-06-14 09:00:00-0400
description: AI agents don't remove management. They remove the places where weak management used to hide.
tags: ai agents management workflows
categories: ai
related_posts: true
---

_Originally published in my newsletter, [In General](https://ingeneral.substack.com/p/managing-agents-is-management-again) — one useful thing I tried, built, or figured out each week. [Subscribe here](https://ingeneral.substack.com/)._

I've been building a lightweight PM system for AI-driven development, and the strangest part is how little of it feels new.

The tools are new. The failure mode isn't.

A task goes into an agent. Code comes out. Sometimes the code is impressive. Sometimes it passes tests. But the real question is older and less exciting: did the work match the intent?

That's a management question.

AI agents don't remove management. They remove the places where weak management used to hide. Vague objectives, missing boundaries, stale context, and loose definitions of done all become more visible when the person doing the work isn't a person.

A human can often survive a badly defined task. They ask a follow-up question. They read the room. They remember what happened in the last meeting. An agent doesn't reliably do that, at least not yet. What it does do is fill the gaps with confident assumptions.

That changed how I think about backlog items.

The task object is the management interface.

I started with ten rules for managing agents. That was too many. Most of them collapsed to the same point: agentic work improves when the management system around the agent becomes more explicit.

The version I keep coming back to is simple.

## Give the agent a job, not a wish

Managing an agent is like managing a person in one basic way: you need to give it a specific task and a specific outcome.

"Make this better" isn't a job.

A job says what should happen when the work is done. It gives the agent something to steer toward. That matters even more once the agent has loops and goals, because now it can keep processing until it thinks it has reached the target. If the target is vague, the loop just lets it get confidently vague for longer.

The line I keep coming back to:

> A vague task doesn't produce a vague result. It produces a wrong result that looks right.

With a human, vague work usually creates visible friction. The person slows down. They ask for clarification. They push back. Agents are less helpful that way. They'll happily produce a polished artifact from a muddy task.

So specificity is safety equipment.

The shape I landed on for backlog issues is intentionally small:

- Goal
- Behavior
- Out of scope
- Notes

That's it. No user story ceremony. No implementation plan pretending to be a requirement. As lightweight as possible.

The goal is one sentence: what this does, not how. The behavior section is two to four observable statements. "File doesn't reappear in the list after being deleted" is useful. "Deletion works correctly" isn't.

The out-of-scope section is mandatory. Agents expand scope confidently. They refactor adjacent code. They improve nearby paths. They notice something else, and "while I was here" becomes their way into reviewing debt.

Naming the boundary turns scope from a private assumption into a rail the agent can run against.

## Put the feedback loop inside the task

Feedback loops are how agents start giving good results.

The task needs gates. Without gates, the agent is just moving.

This is why test-driven development maps so well to agent work. A good test gives the agent something to loop against. A good acceptance criterion does the same thing. It gives the agent a clear standard rather than a vibe.

The behavior bullets are the acceptance criteria. If they're precise enough, an agent can write tests against them. If the agent can't write tests against them, I probably haven't described the behavior clearly enough.

That turns a task from "please build the thing I have in my head" into something closer to a working contract. The agent can implement against it. CI can check part of it. I can review it.

The loop matters more than the model.

A better model inside a sloppy system produces prettier slop. A decent model inside a clear loop can do useful work.

## Keep the work small enough to review

I don't do much one-shot prompting. I do a lot of small PRs.

That's partly for the agent, but mostly for me.

A small PR means I don't have to understand one giant complicated problem. I can focus on exactly what this issue or PR is trying to accomplish. That keeps the context down, sharpens the requirements, and speeds up review.

Smaller work also makes the other rules easier to enforce: easier to name the goal, write behavior bullets, define out of scope, and see whether the tests prove anything.

Some agent demos point people in the wrong direction. The fantasy is one giant autonomous agent running a huge chunk of the business. The useful version looks more like lanes: narrow work, clear ownership, smaller permissions, and smaller receipts.

That doesn't mean the model is incapable of doing more. It means I'm designing the system so I can still manage the work.

## Use the right context, not the most context

The goal isn't maximum context. It's the right context.

In my process, I have infrastructure in place to clear context when I'm building plans. I want the agent to engage with the right parts of the codebase, not drag every stale note, previous assumption, and irrelevant file into the task.

Most of my codebases are Ruby on Rails, and Rails apps are naturally broken into small files with a lot of convention. The agent doesn't have to ingest one giant blob of application logic just to work on a problem.

The broader point isn't Rails specifically. It's the convention and structure that make context easier to manage.

A small, well-structured context is easier for the agent to use than a huge pile of old context. Bad context isn't neutral. Agents over-obey context. A stale instruction becomes automated institutional memory.

Keep context scoped, current, or gone.

## Trust should leave receipts

Trust should be tangible.

Getting things done quickly might feel good, but it isn't the same as trust. I trust the workflow more when I can review the PR, understand the tests, and see the code working toward passing them. I trust it when the agent reports back against the task it was given, not just when it opens a branch.

A PR isn't enough. A branch isn't enough. A test run isn't enough. Those are activity artifacts.

The management question is simpler: did it do the job?

If the task says there are four behavior bullets, the agent should report back against those four bullets. If the task says "don't touch billing," the report should confirm billing wasn't touched. If anything is unclear, destructive, customer-facing, security-sensitive, or outside the named scope, the agent should stop and ask.

The human stays in the loop where judgment matters: business requirements at the front, optional plan review in the middle, PR review before merge. Not constantly in the loop. Deliberately in the loop.

When the result is wrong, I don't just blame the model. I look at the process: requirement, skill, workflow, gate, execution, and review scope.

That's what I mean when I say managing agents is management again.

Not less management. More explicit management.

That's the part I'm trying to make boring enough to rely on.
