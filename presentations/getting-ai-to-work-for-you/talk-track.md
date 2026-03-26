# Talk Track — The Moat Isn't the Model.
ERA // March 2026

---

## Slide 1 — The Moat Isn't the Model.

**→ Chaos of the cohort**
**→ Tools changed faster than strategies**
**→ Systems survive; tools don't**

"I want to talk to all of you.

You are building companies during what might be the most disorienting period in the history of technology. In the last several months, the tools changed faster than the strategies. The models got replaced before you finished learning them. The playbook everyone handed you in January was already wrong — and you still had to ship.

That's an incredible position to be in. Because the founders who figure out how to build systems that survive that chaos — not just use the tools that are hot right now — are going to have a real edge.

That's what I want to talk about today. I'm Chuck Blake — I was CTO of an ERA company, recently left. I bought a Mac mini, built an AI agent named Gomez, and went deep. What I learned is this: the moat isn't the model."

---

## Slide 2 — Meet Gomez.

**→ What Gomez is and does**
**→ Chewing on glass — honest about the pain**
**→ There's real upside if you go beyond the tool**

"I bought a Mac mini, installed OpenClaw, named my agent Gomez, and started trying to get him to actually help me — monitor my businesses, help with software development, manage my personal CRM, handle knowledge management, think through problems.

A lot of people describe OpenClaw as chewing on glass. Painful, not always useful, but very interesting if you like to tinker. And I think there's a lot of upside beyond just going down the rabbit hole — if you approach it the right way."

---

## Slide 3 — Building a System, Not Just Using a Tool

**→ You install OpenClaw and you have a commodity**
**→ You give it a soul — identity, personality, context, knowledge**
**→ Every customization is what makes it yours**

"Here's what I realized. You install OpenClaw — or any agent harness — and what you have is a commodity. A model. Everyone has the same thing. But then you start customizing it. You give it an identity. You tell it who it's working for, how to communicate, what rules to follow. You feed it your context — your knowledge base, your notes, your preferences. You build skills for the specific things you need it to do.

And what happens is this generic commodity thing slowly becomes something unique. Something that knows you, works the way you work, reflects your judgment. The model doesn't know who you are. You have to tell it. That's the work — and that's the moat."

---

## Slide 4 — Three Ways to Build That System

**→ Memory**
**→ Context**
**→ Principles**

"I broke it down to three things. Memory, context, and principles. None of them are OpenClaw-specific. They live in files on your computer. You can move them anywhere. Let me take them one at a time."

---

## Slide 5 — 1. Memory

**→ Out of the box memory didn't work — had to build it**
**→ Layered system: logs, errors, identity, vector DB**
**→ It's YOUR thinking, not the model's**

"OpenClaw comes with its own memory system. Mine didn't work great out of the box — it would forget things mid-conversation, lose context between sessions. So I had to do a lot of tweaking.

What I ended up with is a layered system: a daily log of what happened, an errors file where it logs its own mistakes so it doesn't repeat them, an identity file with overarching rules for how it should behave. And on top of that — Mem0, a vector database running locally. I'm building up a real database of memories over time that I can query by meaning, not just keyword. Every time I'm in a chat, before it answers, it searches that database for what's relevant."

---

## Slide 6 — How Memory Works

**→ Raw inputs flow into long-term memory**
**→ Boots in sequence: identity → errors → memory → today**
**→ Portable — just markdown files**

"Here's how it flows. Raw inputs — daily logs, error logs, identity rules — get distilled into long-term memory and continuously into the vector database. Every time Gomez boots, he loads in sequence: who he is, what mistakes not to repeat, long-term context, today's log, semantic search. By the time he's ready to work, he's not starting from zero. And because it's all just markdown files, it's completely portable."

---

## Slide 7 — Example: Memory

**→ Before I typed a word, he already knew**
**→ Hates Slack — that's my thinking, not the model's**
**→ The vehicle vs. the driver**

"Quick demo. When I started this session today — before I typed a single word — Gomez queried the vector DB with 'ERA presentation.' These are the memories that came back.

[show slide]

He already knew I was presenting here today, where I keep my slides, how I like to work. And — importantly — that I hate Slack." [pause] "That's my thinking, not the model's. He's just the vehicle."

---

## Slide 8 — 2. Context

**→ Generic prompts, generic output**
**→ Personal context = personal output**
**→ Your context is the moat**

"Generic prompts get generic output. The model has no idea who you are, what you've decided, what you care about. But if you give it curated personal context — your preferences, your history, your specific knowledge — the output starts to sound like you and reflect your actual situation. Your context is the moat."

---

## Slide 9 — What's In The Vault

**→ Obsidian knowledge base — everything in one place**
**→ Readwise pulls in all reading/highlights**
**→ QMD makes it all searchable by meaning**

"I keep my context in an Obsidian vault — a personal knowledge base. People, journal, decisions, health logs, meeting notes, reading highlights, project context. I use Readwise to capture articles and highlights, so all that comes in too. The whole vault is indexed and vectorized with a tool called QMD — hybrid keyword and semantic search.

The question I ask myself: if I onboarded a new human assistant tomorrow, what would I need them to know? That's what goes in here."

---

## Slide 10 — Example: Context

**→ Asked: what is Murat's degree in?**
**→ Vault found the note, surfaced the answer**
**→ Not the model being smart — the vault being useful**

"Quick demo. I asked: what is Murat's degree in? Gomez searched my vault, found my note on Murat — which I built from his LinkedIn — and came back with: MS Computer Science, Neural Networks and Machine Learning. ERA co-founder. 400-plus investments. Chuck is presenting to him on March 27.

[show slide]

That's not the model being smart. That's my vault being useful."

---

## Slide 11 — 3. Principles

**→ Every interaction is a new negotiation — doesn't scale**
**→ Embed your judgment into the system**
**→ Bottleneck shifted from execution to judgment**

"Most people direct every AI interaction individually. Every prompt is a new negotiation. That doesn't scale. Principles are a way to embed your judgment into the system itself — so you stop being in every loop. Your standards are.

The bottleneck used to be execution. AI mostly solved that. Now the bottleneck is judgment. That's actually the right problem to have."

---

## Slide 12 — What A Principle Looks Like In The Repo

**→ CLAUDE.md committed to every repo**
**→ Agent reads it every session — inherits your rules**
**→ You never mentioned the API. The principle did.**

"I have a file called CLAUDE.md committed to every one of my repos. The coding agent reads it at the start of every session — same way Gomez reads his identity file. One principle: API-first. Any feature in the UI must also exist in the API. All new endpoints require tests before merge.

So when I ask the agent to add bulk tag filtering to search, I just say 'add it.' His plan comes back: add the API endpoint, write the tests, build the UI against the API. I never mentioned the API. The principle did.

Write it once. Every agent that touches that repo inherits your judgment."

---

## Slide 13 — The Model Is Replaceable. The System You Build Around It Is Yours.

**→ Same models, different systems — that's the whole game**
**→ The gap compounds with every correction, every principle**
**→ Files are yours forever — platform doesn't matter**

"Everyone in this room has access to the same models. But nobody else has your memory, your context, your judgment baked into a system. That gap compounds. Every correction you log, every principle you commit — it widens.

And because it all lives in files, it's yours permanently. OpenClaw could disappear tomorrow. Claude could get replaced next year. The files go with you. That's the moat."

---

## Slide 14 — Find Me

**→ Slides at the URL**
**→ Come find me**

"Happy to dig into any of this. Slides are at that URL — everything I showed you today is in there. Come find me."
