# Talk Track — The Moat Isn't the Model.
ERA // March 2026

---

## Slide 1 — The Moat Isn't the Model.

"I want to start with a claim. The moat isn't the model. Everyone in this room has access to GPT, Claude, Gemini — the same tools, the same capabilities. So if the model is the same for everyone, where does the edge come from? That's what this talk is about. And to explain it, I need to introduce you to Gomez."

---

## Slide 2 — Meet Gomez.

"Gomez is my AI chief of staff. He lives on a Mac mini in my apartment, connected to Telegram, my calendar, my code, my task manager. He has opinions. He is not always right. Building him was genuinely painful — there were weeks where I thought I was getting real work done and I wasn't. But that pain turned out to be useful."

---

## Slide 3 — What I Learned

"The model is a commodity. It will be replaced — probably multiple times. GPT-4 was state of the art eighteen months ago. The system you build around the model is the only thing that compounds. Your memory, your context, your judgment baked in. I ended up with five ideas for building that system. None of them require OpenClaw. Build them in files, and any platform that reads those files inherits your system."

---

## Slide 4 — Five Ways to Build That System

"The five ideas are: Memory, Context, Skills, Evals, and Principles. These aren't a framework — I'm not selling anything. They're just what's been working. Let me take them one at a time."

---

## Slide 5 — 1. Memory

"The first problem I hit with Gomez was that he woke up fresh every session with no idea who I was or what we'd been working on. So I built a memory system. Identity — who he is and how to communicate. Errors — a log of every mistake so he doesn't repeat them. Long-term memory — distilled decisions and preferences. And a daily log of what actually happened. On top of that, a local vector database — Mem0 and Qdrant — so he can search memory by meaning, not just by keyword. The key insight: none of this is the model's thinking. It's mine. He's just the vehicle."

---

## Slide 6 — How Memory Works

"Here's how it flows. Raw inputs on the left — daily logs, mistake logs, identity rules. Those get distilled weekly into long-term memory and continuously into the vector database. Every time Gomez boots, he loads in sequence: who he is, what mistakes not to repeat, long-term context, today's log, semantic search. By the time he's ready to work, he's not starting from zero — he's starting from everything I've told him that matters. One portable brain, regardless of what model is running underneath."

---

## Slide 7 — 2. Context

"Second idea: context. Generic prompts get generic output. The model has no idea who you are, what you've decided, what you care about. But if you give it curated personal context — your preferences, your history, your specific knowledge — the output starts to sound like you. Your context is the moat."

---

## Slide 8 — What's In The Vault

"I keep my context in an Obsidian vault — a structured knowledge base. People, journal, decisions, health logs, meeting notes, reading highlights, project context. The whole thing is indexed and vectorized with a tool called QMD — hybrid keyword and semantic search. The question I ask myself is: if I onboarded a new human assistant tomorrow, what would I need them to know? That's what goes in the vault."

---

## Slide 9 — 3. Skills

"Third idea: skills. The worst habit people have with AI is writing one-off prompts for everything. You do it once, get a good result, and the next time you need the same thing you start over. A skill is a reusable instruction set — a text file that tells the agent exactly how to do a specific task. Not model-specific. I have about 75 of them. Each one took maybe twenty minutes to write. Each one saves that time every time it runs. The pattern is always the same: the LLM decides and orchestrates, scripts execute the actual work."

---

## Slide 10 — Skills in Practice

"Three examples. Good-morning: the LLM asks me health questions conversationally, a script logs the answers. Deploy: the LLM decides the sequence, watches CI, reads logs, verifies the deploy actually worked — while scripts handle git, tokens, Heroku API calls. Process-inbox: the LLM suggests GTD-style task names, scripts call OmniFocus directly. The intelligence is in the LLM. The reliability is in the scripts. You need both."

---

## Slide 11 — 4. Evals

"Fourth idea: evals. This is the one most people skip, and it's why most people's AI setups quietly degrade over time. An eval is a test for AI output. Without evals you're improving by feel — 'this seems better?' That's not a feedback loop, that's a vibe. I use a tool called Autoresearch: it runs a skill repeatedly, scores the output against a set of binary questions, mutates the prompt, keeps improvements. You cannot improve what you cannot measure. This is true for software. It's especially true for AI."

---

## Slide 12 — What An Eval Actually Looks Like

"Here's a real example. Six yes/no questions for my morning briefing skill. Does it contain all seven required sections? Any placeholder text? Does the subject line include today's date? Is every item actionable, not just informational? Does the tone match — direct, no filler? Does the HTML render cleanly? Each question is binary. Score is questions passed over total. My baseline was 33%. Four prompt mutations later: 100%. That's the loop. Run it, score it, fix it, repeat."

---

## Slide 13 — 5. Principles

"Fifth idea: principles. Most people direct every AI interaction individually. Every prompt is a new negotiation. That doesn't scale. Principles are a way to embed your judgment into the system itself so you stop being in every loop — your standards are. The bottleneck used to be execution. AI mostly solved that. Now the bottleneck is judgment. That's actually the right problem to have."

---

## Slide 14 — What A Principle Looks Like In The Repo

"Here's a concrete example. I have a principle in CLAUDE.md — a file committed to every repo, read by the agent every session — that says: API-first. Any feature that exists in the UI must also exist in the API. All new endpoints require tests before merge. So when I ask Gomez to add bulk tag filtering to search, I just say 'add it.' His plan comes back: add the API endpoint, write the tests, build the UI against the API. I never mentioned the API. The principle did. Write it once. Every agent that touches that repo inherits your judgment."

---

## Slide 15 — The Model Is Replaceable. The System You Build Around It Is Yours.

"So that's the thesis. Everyone has access to the same models. Nobody else has your memory, your context, your judgment baked into the system. That gap compounds. Every skill you build, every correction you log, every principle you commit — it widens. And because it all lives in files, it's yours permanently. OpenClaw could disappear tomorrow. Claude could get replaced next year. The files go with you. That's the moat."

---

## Slide 16 — Find Me

"Happy to talk more about any of this. Slides are at that URL. Come find me."
