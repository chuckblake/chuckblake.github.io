# One-Pager Talk Track
ERA // March 2026

---

**Slide 1 — Building an AI System That Works for You**
- CTO of an ERA company, recently left
- Bought a Mac mini, built an agent named Gomez
- Tools are moving faster than strategies
- Most people stop at the tool — this is about going deeper
- Building a system that survives the chaos

---

**Slide 2 — Meet Gomez**
- OpenClaw, running locally on a Mac mini
- Connected to Telegram, calendar, code, tasks
- Honest: painful to build at first
- Worth it if you go beyond just using a model

---

**Slide 3 — Building a System, Not Just Using a Tool**
- Install OpenClaw = commodity, same as everyone
- Give it a soul: identity, personality, preferences
- Every customization makes it uniquely yours
- The model doesn't know who you are — you have to tell it

---

**Slide 4 — Three Ways to Build That System**
- Memory
- Context
- Principles

---

**Slide 5 — 1. Memory**
- Out of the box memory wasn't good enough
- Built a layered system on top
- Daily log, errors file, identity file
- Mem0 + Qdrant: vector DB running locally
- It's YOUR thinking stored, not the model's

---

**Slide 6 — How Memory Works**
- Raw inputs → long-term memory + vector DB
- Boot sequence: identity → errors → memory → today's log → semantic search
- All just markdown files — completely portable

---

**Slide 7 — Example: Memory**
- Before I typed a word, he queried the vector DB
- Already knew about this talk, my slides, how I work
- Already knew I hate Slack
- My thinking, not the model's

---

**Slide 8 — 2. Context**
- Generic prompts → generic output
- Personal context → personal output
- Your knowledge base is the differentiator
- Your context is the moat

---

**Slide 9 — What's In The Vault**
- Obsidian vault: people, decisions, notes, journal, health
- Readwise pulls in all reading + highlights
- QMD: hybrid keyword + semantic search across all of it
- Ask yourself: what would I tell a new human assistant?

---

**Slide 10 — Example: Context**
- Asked: what is Murat's degree in?
- Vault found the note, surfaced the answer
- MS Computer Science, Neural Networks + ML
- Not the model being smart — the vault being useful

---

**Slide 11 — 3. Principles**
- Directing every interaction doesn't scale
- Embed your judgment into the system
- Bottleneck shifted from execution to judgment
- That's the right problem to have

---

**Slide 12 — What A Principle Looks Like In The Repo**
- CLAUDE.md committed to every repo
- Agent reads it every session
- Principle: API-first, tests before merge
- I just say "add it" — the principle handles the rest
- Write once, every agent inherits your judgment

---

**Slide 13 — The Model Is Replaceable. The System Is Yours.**
- Same models, different systems — that's the whole game
- Gap compounds: every correction, every principle widens it
- Lives in files — platform doesn't matter
- OpenClaw could disappear. The files go with you.

---

**Slide 14 — Find Me**
- Slides at the URL
- Happy to dig in
