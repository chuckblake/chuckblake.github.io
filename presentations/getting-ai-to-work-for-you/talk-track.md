# Talk Track — Five Ideas for Getting AI to Work for You
**Chuck Blake // ERA // March 2026**

---

## Slide 1a — Title (headline only)

*Let it land. Pause before speaking.*

---

## Slide 1b — Title with subheading + Mac mini photo

"This is Gomez. He runs on that Mac mini in my office. He has opinions about how I should be doing things, and honestly? He's usually right.

I've been building this for about a year — a personal AI system that actually gets things done for me. Not a chatbot I talk to. A system that runs, acts, remembers, and gets better over time.

Tonight I want to share five ideas that came out of that. These are as much reminders for myself as takeaways for you. I'm still figuring this out. But some things are starting to work."

---

## Slide 2 — Everyone's Using AI

"Every single person in this room has used AI in the last week. Probably more than once.

But here's the question I keep asking myself: is my business actually moving faster? Or am I just doing the same things in a slightly more interesting way?

The rabbit hole is real. It's very easy to spend three hours trying to get a prompt just right and call it productivity. I've done it.

The thing I have to constantly remind myself — and I mean constantly — is that the goal isn't to use more AI. The goal is to get more done."

---

## Slide 3 — A Personal AI Chief of Staff

"So what did I actually build?

I think of Gomez as a Chief of Staff. Not a chatbot. A chatbot answers questions when you ask them. A Chief of Staff shows up, knows what's going on, takes action, and reports back.

He runs locally on my machine — my data never leaves my control. He's connected to my calendar, my task manager, my code, my email. He's always on. And he has memory — which is the part I want to dig into tonight."

---

## Slide 4 — It Did Not Go Perfectly

"I want to be honest with you about how this went, because I think the failure story is actually the useful part.

I built too many things at once. None of them were solid.

He confidently marked tasks as done that were not done. A sub-agent I had running recreated a cron job I had just killed — so I had two of the same job firing. My morning briefing was going out at 5pm.

And my personal favorite: I accidentally crashed the server with 287 re-queued jobs.

The recurring theme was: I built something, it seemed to work, I moved on. It was not working."

---

## Slide 4b — Five Ideas

"So out of all that chaos, here are the five things I keep coming back to. These aren't a framework — I'm not that organized. They're just the five areas where I've been putting my energy, and where I've seen the most return."

*Read through the list. Briefly, one line each.*

---

## Slide 5 — 1. Memory

"Every AI session starts fresh. The model has no idea who you are, what you were working on yesterday, or what mistakes it made last week.

The only way to fix that is to build a memory system — files that persist, that get read at the start of every session, that make the agent feel like it knows you.

I have four layers: an identity file, an errors log, a long-term memory file, and a daily log. And then a vector database that lets me search all of it semantically."

---

## Slide 5b — How Memory Works

"Here's how it actually flows.

On the left: the raw inputs. Every session I'm logging what happened. Any mistake gets written to errors.md immediately — same session, no waiting. And my identity file is stable — it rarely changes.

Those feed into the long-term layer. MEMORY.md is curated weekly — distilled lessons and decisions. Mem0 and Qdrant handle semantic search — so instead of keyword matching, it finds memories by meaning.

And then every time a session starts, the agent boots by loading all of that in order. It wakes up knowing who it is and what matters. That's the demo I'll show in a minute."

---

## Slide 6 — 2. Context

"Memory is about what the agent knows over time. Context is about what you feed it right now.

Raw prompts get generic output. That's because the model is drawing on everything it was trained on — the entire internet, basically. When you add your specific context — your notes, your errors, your preferences — you get output that actually sounds like you and fits your situation.

The model is a commodity. Everyone has access to the same Claude, the same GPT. What nobody else has is your context. That's the moat."

---

## Slide 6b — What's In The Vault

"My context lives in an Obsidian vault — a personal knowledge base I've been building for years.

People, journal, decisions, health data, meeting notes, reading highlights, project context — all of it in markdown files, all of it indexed and searchable via a tool called QMD.

When I ask Gomez something about a specific person or project, he's not guessing. He's searching my vault. I'll show you exactly what that looks like."

---

## Slide 7 — 3. Skills

"A skill is a reusable instruction set for a specific task.

Not a prompt you type every time. A file. A system. Something you build once and use forever.

I have about 75 skills right now — good morning, deploy, process inbox, grill me, era demo... Each one took maybe 20 minutes to build. Each one saves me hours over time.

And here's the key thing: they're not model-specific. When Claude gets replaced by something better, my skills come with me."

---

## Slide 7b — Skills in Practice

"Every skill follows the same pattern: the LLM decides, the script executes.

Take process-inbox. The LLM reads my OmniFocus inbox, understands what each task actually means, and suggests a clean GTD-style action name. That's the judgment call — only a human or a well-trained AI can do that well.

Then the script handles the execution. MCP calls write directly to OmniFocus. No copy-paste, no app switching, no hallucination in the execution layer.

The LLM is good at judgment. Scripts are good at reliability. Keep them in their lanes."

---

## Slide 8 — 4. Evals

"This one took me the longest to appreciate.

An eval is a test for AI output. Binary questions — yes or no — that you run against every response the system generates.

Without evals, you're improving by feel. 'That seemed better, I think?' With evals, you have a score. You can iterate, you can catch regressions, you can ship with confidence.

I have a skill called Autoresearch that does this automatically — runs a skill dozens of times, scores the output, mutates the prompt, and keeps the improvements."

---

## Slide 8b — What An Eval Actually Looks Like

"Here's what the eval for my morning briefing looks like. Six questions, all binary.

Does it have all seven sections? Is there any placeholder text? Does the subject line have today's date and a specific summary? Is every item actionable? Is the tone right? Does the HTML render cleanly?

That's it. Run those questions against every output, take the percentage that passes. Baseline was 33%. Four mutations later, it was 100%.

No vibes. Just a score."

---

## Slide 9 — 5. Principles

"The last idea is the one I think about most when I'm building.

Ford's assembly line was incredibly efficient — but someone had to direct every step. The bottleneck was always the person at the top.

Warhol ran the Factory differently. His taste was in the system. His collaborators could produce without him directing each individual piece. He scaled his judgment, not his presence.

That's the goal. Not to be in every loop — but to have your judgment embedded in the system so it runs without you."

---

## Slide 9b — What A Principle Looks Like In The Repo

"Concretely: principles live in a file in the repo called CLAUDE.md. The coding agent reads it at the start of every session — exactly the way Gomez reads his identity file.

I write the principle once. It gets committed to git. Every agent that touches the project inherits it.

In this example: API-first. Any functionality in the UI must also exist in the API. When I ask the agent to add bulk tag filtering to a search page — I never mention the API. The agent builds the endpoint first, then the tests, then the UI. Because the principle told it to.

That's my judgment, scaled."

---

## Slide 10 — Your Context Is The Moat

"I'll leave you with this.

Everyone in this room has access to the same AI. GPT, Claude, Gemini, whatever comes out next month. The model is a commodity.

What nobody else has is your memory, your context, your judgment embedded in your system. That gap compounds. Every skill you build, every correction you log, every principle you commit — it gets wider.

The model is replaceable. The system you build around it is yours."

---

## Slide 11 — Find Me

"Happy to keep talking about any of this.

chuckblake.com, @chuckblake on X, /in/chuckblake on LinkedIn. The slides are at the URL on screen — and if you want to see the demos live, just ask."

---
