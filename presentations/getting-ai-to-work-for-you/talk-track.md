# Talk Track — The Moat Isn't the Model.
ERA // March 2026

---

## Slide 1 — The Moat Isn't the Model.

"Hey, I'm Chuck Blake. I was CTO of an ERA company that I recently left, so I'm one of you — or I was. Today I want to start with a claim: the moat isn't the model. Everyone in this room has access to GPT, Claude, Gemini — the same tools, the same capabilities. So if the model is the same for everyone, where does the edge come from? That's what I want to talk about."

---

## Slide 2 — Meet Gomez.

"So while you guys have been building your companies — and I can't even imagine how the last couple months have been, this must have been the most chaotic cohort ever — I bought a Mac mini, installed OpenClaw, named my agent Gomez, and started trying to get him to help me run my life. Monitor my businesses. Help with software development. Organize my personal CRM. Knowledge management. Thinking through problems.

It's been an interesting journey. A lot of people describe OpenClaw as chewing on glass — painful, not always useful, but very interesting if you like to tinker. And I think there is a lot of upside beyond just going down the rabbit hole."

---

## Slide 3 — What I Learned

"Here's the thing I keep coming back to. Opus 4, Haiku, GPT, Codex — the models are coming and going. There's going to be a better model every few months. So I started asking: how do I build something that's going to be valuable regardless of which model I'm running?

The answer is: you build the system around the model, not on top of it. And you build it in files — plain text that any platform can read. Because I don't expect OpenClaw to be the last system I use. Whether it's OpenClaw or Perplexity or Claude or whatever comes next — I want everything I've built to transfer. That's the whole point."

---

## Slide 4 — Three Ways to Build That System

"I broke it down to three things. Memory, context, and principles. None of them are OpenClaw-specific. They live in files on your computer and you can move them anywhere. Let me take them one at a time."

---

## Slide 5 — 1. Memory

"OpenClaw comes with its own memory system. Mine didn't work great out of the box — it would forget things mid-conversation, lose context between sessions. So I had to do a lot of tweaking.

What I ended up with is a layered system: a daily log of what happened, an errors file where it logs its own mistakes so it doesn't repeat them, an identity file with overarching rules for how it should behave. And then on top of that — Mem0, a vector database running locally. So I'm building up a real database of memories over time that I can query by meaning, not just keyword. Every time I'm in a chat, before it answers, it searches that database for what's relevant."

---

## Slide 6 — How Memory Works

"Here's how it flows. Raw inputs — daily logs, error logs, identity rules — get distilled weekly into long-term memory and continuously into the vector database. Every time Gomez boots, he loads in sequence: who he is, what mistakes not to repeat, long-term context, today's log, semantic search. By the time he's ready to work, he's not starting from zero. And because it's all just markdown files, it's completely portable."

---

## Slide 7 — Example: Memory

"Quick demo. When I started this session today — before I typed a single word — Gomez queried the vector DB with the topic 'ERA presentation.' These are the memories that came back.

[show slide]

He already knew I was presenting here today, where I keep my slides, how I like to work. And — importantly — that I hate Slack." [pause] "That's my thinking, not the model's. He's just the vehicle."

---

## Slide 8 — 2. Context

"Second idea: context. Generic prompts get generic output. The model has no idea who you are, what you've decided, what you care about. But if you give it curated personal context — your preferences, your history, your specific knowledge — the output starts to sound like you and reflect your actual situation. Your context is the moat."

---

## Slide 9 — What's In The Vault

"I keep my context in an Obsidian vault — a personal knowledge base. People, journal, decisions, health logs, meeting notes, reading highlights, project context. I use Readwise to do read-it-later and article highlighting, so all that comes in too. The whole vault is indexed and vectorized with a tool called QMD — hybrid keyword and semantic search.

The question I ask myself is: if I onboarded a new human assistant tomorrow, what would I need them to know? That's what goes in here."

---

## Slide 10 — Example: Context

"Quick demo. I asked: what is Murat's degree in? Gomez searched my vault, found my note on Murat — which I built from his LinkedIn — and came back with: MS Computer Science, Neural Networks and Machine Learning. ERA co-founder. 400-plus investments. Chuck is presenting to him on March 27.

[show slide]

That's not the model being smart. That's my vault being useful."

---

## Slide 11 — 3. Principles

"Third idea: principles. Most people direct every AI interaction individually. Every prompt is a new negotiation. That doesn't scale. Principles are a way to embed your judgment into the system itself — so you stop being in every loop. Your standards are.

The bottleneck used to be execution. AI mostly solved that. Now the bottleneck is judgment. That's actually the right problem to have."

---

## Slide 12 — What A Principle Looks Like In The Repo

"Here's a concrete example. I have a file called CLAUDE.md committed to every one of my repos. The coding agent reads it at the start of every session — same way Gomez reads his identity file. One principle in there says: API-first. Any feature that exists in the UI must also exist in the API. All new endpoints require tests before merge.

So when I ask the agent to add bulk tag filtering to search, I just say 'add it.' His plan comes back: add the API endpoint, write the tests, build the UI against the API. I never mentioned the API. The principle did.

Write it once. Every agent that touches that repo inherits your judgment."

---

## Slide 13 — The Model Is Replaceable. The System You Build Around It Is Yours.

"So that's the thesis. Everyone in this room has access to the same models. But nobody else has your memory, your context, your judgment baked into a system. That gap compounds. Every correction you log, every principle you commit — it widens.

And because it all lives in files, it's yours permanently. OpenClaw could disappear tomorrow. Claude could get replaced next year. The files go with you. That's the moat."

---

## Slide 14 — Find Me

"Happy to dig into any of this. Slides are at that URL — everything I showed you today is in there. Come find me."
