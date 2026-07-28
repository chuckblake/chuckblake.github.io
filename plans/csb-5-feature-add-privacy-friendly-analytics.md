---
title: "CSB-5: Add privacy-friendly analytics to measure the search-to-Calendly funnel"
type: feat
status: active
priority: p2
created: 2026-07-27
effort: medium
tags: [analytics, seo, fathom, open-graph, jekyll]
issue_id: CSB-5
---

# CSB-5: Add privacy-friendly analytics to measure the search-to-Calendly funnel

## Goal

Close the measurement and link-preview gaps on chuckblake.com for two grouped backlog issues shipped
as one branch and one PR:

- **CSB-5** — make the search → fractional-CTO → Calendly funnel measurable by tracking outbound
  Calendly CTA clicks as a named Fathom event.
- **CSB-4** — replace the square profile photo used as the sitewide Open Graph preview with a proper
  1200×630 card, and fix the Twitter card type so that card actually renders wide.

The backlog issues own the acceptance criteria; this plan owns the engineering response.

---

## Problem Frame

The site had no measurement when CSB-5 was filed. That premise is now **stale**: commit `5243562`
("feat: add Fathom analytics tracking") added a hardcoded Fathom script to `_includes/head.liquid`,
so pageview analytics are already live and already cookie-banner-free. What is still missing is the
*conversion* half — nothing records that a visitor clicked through to Calendly, which is the single
event that makes the funnel a funnel rather than a traffic count.

Separately, every link shared to LinkedIn, X, Slack, or iMessage renders `prof_pic.jpg`, a square
headshot, in a preview slot that expects 1200×630. It gets cropped or letterboxed at exactly the
moments the site is being passed to a referral or a recruiter.

---

## Key Assumption (stated explicitly — it reshapes CSB-5)

**Fathom Analytics is the provider. Do not install a second one.**

`_includes/head.liquid` already carries:

```
<script src="https://cdn.usefathom.com/script.js" data-site="BGSBQDLW" defer></script>
```

This is hardcoded, *not* wired through al-folio's `_config.yml` analytics flags — every
`enable_*_analytics` key is `false` and every `*_analytics` ID cell is empty. Those empty
`pirsch_analytics:` / `enable_pirsch_analytics:` cells are a trap: CSB-5's body *recommends* Pirsch,
but that recommendation predates the Fathom install. Wiring Pirsch now would mean two trackers on
every page.

Fathom is cookie-banner-free, so CSB-5's "analytics live on all pages" and "no cookie-consent banner"
criteria are already satisfied by the current `main`. This plan therefore builds only the conversion
event on top of the existing install, and leaves every `_config.yml` analytics cell untouched.

---

## Scope Boundaries

- No second analytics provider (Pirsch, Openpanel, Google Analytics) — see Key Assumption.
- No migration of the existing hardcoded Fathom tag into `_config.yml` flags. It works; churning it
  risks the live install for no user-visible gain.
- No per-page `og_image` overrides. One sitewide default only.
- No generic all-outbound-link tracking. CSB-5's Scope says "one goal for Calendly clicks"; a
  site-wide external-link tracker would create an unbounded set of event names.
- `assets/img/prof_pic.jpg` is not modified, moved, or replaced — the About page renders it.
- No dashboards or reports beyond Fathom's defaults.

### Deferred to Follow-Up Work

- Distinguishing which page a Calendly click came from (home vs. fractional-cto) via separate event
  names. Deliberately deferred: CSB-5 asks for *one* goal, and event names are the aggregation unit
  in Fathom, so splitting them is a one-way door on the metric's history.

---

## Context & Research

### Relevant Code and Patterns

- `_includes/head.liquid:16-18` — the existing Fathom script block. Any event code must run after it.
- `_includes/head.liquid:11-14` — Content-Security-Policy meta tag. `script-src 'self' 'unsafe-inline'
  https:` and `connect-src 'self' https:` already permit both the Fathom CDN and a site-owned script.
  No CSP change is expected; it is listed as a surface to *verify*, not to edit.
- `_includes/scripts.liquid` — the repo's precedent for site-owned behavior JS, e.g.
  `<script defer src="{{ '/assets/js/newsletter.js' | relative_url | bust_file_cache }}">`. New JS
  follows this shape (`defer` + `relative_url` + `bust_file_cache`).
- `_includes/metadata.liquid:69-71, 78-80` — emit `og:image` / `twitter:image` from the **raw**
  `site.og_image` value with no `absolute_url` filter applied. This is why the config value must stay
  a fully-qualified URL.
- `_includes/metadata.liquid:75` — `<meta name="twitter:card" content="summary">`, hardcoded.
- `_config.yml:203-224` — Jekyll `exclude:` list. Non-site tooling directories are added here (the
  `plans/` entry is the existing precedent, with a comment explaining why).
- `_sass/_themes.scss:13` — `--global-theme-color: #116dff`.
- `_sass/_typography.scss:63`, `_sass/_home.scss:23` — `"Newsreader", Georgia, serif` for headings,
  `"IBM Plex Mono", ui-monospace, monospace` for mono accents.

### External References

- Fathom event API: `fathom.trackEvent('event name', { _value: 100 })`. `_value` is optional and in
  cents. `fathom.trackGoal()` is deprecated for new events.
- Fathom events are **auto-created on first fire** — no dashboard pre-registration is required, so
  the event wiring has zero manual prerequisite.
- Fathom does not document per-event referrer breakdown; referrers are a site-level report. This is
  why CSB-5's referrer criterion is a dashboard observation, not code (see Post-merge verification).
- Fathom's own outbound-link recipe (`usefathom.com/docs/events/external-clicks`) iterates
  `document.querySelectorAll('a')` on `load` and does **not** address the navigate-away race,
  `target="_blank"`, or beacon delivery. U1 deviates from it deliberately; see that unit's Approach.

---

## Key Technical Decisions

- **Delegated listener on `document`, not `querySelectorAll('a')` at load.** One listener, matched via
  `event.target.closest(...)`. Survives any content inserted after load and avoids attaching N
  listeners. Fathom's published recipe does the latter; this is the deliberate deviation.

- **Match by hostname, not by CSS class.** The two CTAs today carry different classes
  (`home-button home-button--primary` vs `cta-button`) and live in different file types (a Liquid
  layout and a Markdown page). Matching `calendly.com` in the resolved URL covers both and keeps
  working if a third CTA is added anywhere.

- **Give the About-page CTA `target="_blank"`.** This is the fix for the navigate-away race, not a
  cosmetic change. `_pages/fractional-cto.md:246` already opens Calendly in a new tab;
  `_layouts/about.liquid:14` does not, so a same-tab navigation can begin unloading the page before
  the tracking beacon is delivered — the click that matters most would be the one most likely to go
  unrecorded. Making both CTAs `target="_blank" rel="noopener noreferrer"` removes the race entirely
  rather than papering over it with a `preventDefault` + `setTimeout` re-navigation, which degrades
  UX and breaks modifier-clicks. It also makes the two CTAs behave consistently.

- **Single stable event name, `Calendly CTA clicked`.** CSB-5's Scope says one goal. Plain words, no
  special characters or emoji, per Fathom's naming guidance. No `_value` — the click has no monetary
  amount, and a fabricated one would corrupt Fathom's conversion-value reporting.

- **Guard on `typeof fathom`.** The Fathom script is `defer` and served from a third-party CDN that
  ad blockers routinely block. An unguarded call throws a `ReferenceError` on every CTA click for
  those visitors. The guard means the link still works and the site stays console-clean.

- **Render the OG card from HTML/CSS and screenshot it, rather than generating it.** CSB-4 requires
  consistency with site typography and colors — an HTML card that loads the site's own fonts and
  palette satisfies that by construction and produces pixel-exact text. Generative image models
  garble rendered lettering. Keeping the HTML source in-repo also makes the card regenerable when the
  positioning line or headshot changes.

- **Card copy is reused verbatim, not written.** Name `Chuck Blake` from `_config.yml:5`, positioning
  line `Hands-on technical leadership for teams ready to ship` from `_pages/fractional-cto.md`'s
  `description`. Both are already published on the site. The card is public-facing text, and inventing
  a new tagline here would put an unreviewed claim on every shared link.

- **JPEG, not PNG.** The card embeds a photograph. PNG would blow well past the ~150 KB budget;
  JPEG at high quality lands comfortably under it.

- **Fix `twitter:card` alongside the image.** Shipping a 1200×630 image while `twitter:card` stays
  `summary` leaves X rendering the same small square box — the exact failure CSB-4 exists to end.
  The image change is only half the fix.

---

## Completeness / Wiring Surfaces

Derived by tracing the nearest existing siblings (the current Fathom script tag; `newsletter.js` as
the site-owned-JS precedent; the current `og_image` wiring). Each bullet names a concrete file.

- [ ] `assets/js/analytics-events.js` — new site-owned behavior JS, matching the `newsletter.js` shape.
- [ ] `_includes/scripts.liquid` — `defer` + `relative_url` + `bust_file_cache` include for the above.
- [ ] `_includes/head.liquid` — CSP meta **verified** to already permit the Fathom CDN and a
      first-party script. Expected: no edit. If an edit turns out to be needed, it belongs here.
- [ ] `_layouts/about.liquid` — Calendly CTA gains `target="_blank" rel="noopener noreferrer"`.
- [ ] `_pages/fractional-cto.md` — Calendly CTA verified to already have `target="_blank"`; add
      `rel="noopener noreferrer"` for parity and link hygiene.
- [ ] `tools/og-image/og-card.html` — new, in-repo, regenerable card source.
- [ ] `_config.yml` `exclude:` — add `tools/` so Jekyll does not publish the card source as a page.
- [ ] `assets/img/og-image.jpg` — the new 1200×630 asset, under ~150 KB.
- [ ] `_config.yml` `og_image:` — repointed, still an **absolute** URL.
- [ ] `_includes/metadata.liquid` `twitter:card` — `summary` → `summary_large_image`.
- [ ] `assets/img/prof_pic.jpg` — confirmed **unchanged** (About page consumer).
- [ ] `npx prettier . --write` — clean, since `.github/workflows/prettier.yml` gates the PR.

---

## Implementation Units

- U1. **Track outbound Calendly clicks as a Fathom event**

**Goal:** Fire a single named Fathom event whenever a visitor clicks a Calendly link, reliably enough
that same-tab navigation cannot swallow it.

**Dependencies:** None.

**Files:**
- Create: `assets/js/analytics-events.js`
- Modify: `_includes/scripts.liquid`
- Modify: `_layouts/about.liquid`
- Modify: `_pages/fractional-cto.md`
- Verify (no edit expected): `_includes/head.liquid`

**Approach:**
- Attach one delegated `click` listener on `document`. Resolve the clicked element's nearest anchor
  with `closest('a[href]')`, resolve its `href` against `window.location.href`, and test the resulting
  hostname for `calendly.com` (suffix match, so subdomains count).
- On a match, call `fathom.trackEvent('Calendly CTA clicked')` guarded by a `typeof fathom` check.
- Do **not** `preventDefault()` and do **not** re-navigate on a timer. Reliability comes from both
  CTAs opening in a new tab, which leaves the originating page alive to deliver the beacon.
- Give `_layouts/about.liquid`'s CTA `target="_blank" rel="noopener noreferrer"`; add the same `rel`
  to `_pages/fractional-cto.md`'s existing `target="_blank"` link.
- Include the script from `_includes/scripts.liquid` (end of `<body>`), which is after the Fathom tag
  in `<head>` — so `fathom` is defined by the time a user can click anything.

**Patterns to follow:**
- `_includes/scripts.liquid`'s `newsletter.js` include — `defer`, `relative_url`, `bust_file_cache`.

**Test scenarios:**
- Happy path: click the About-page Calendly CTA on the local build → a `trackEvent` call is observed
  with exactly `Calendly CTA clicked`, and the link still opens Calendly.
- Happy path: same for the fractional-cto page CTA → the same single event name (not a variant).
- Edge case: click an internal nav link → no event fires.
- Edge case: click a non-Calendly external link (e.g. a footer social link) → no event fires, since
  this is Calendly-scoped by decision, not a generic outbound tracker.
- Edge case: click a nested element inside the CTA (the text node inside the anchor) → the event
  still fires, proving `closest()` delegation rather than a direct-target check.
- Error path: with `fathom` undefined (simulating an ad blocker), click a CTA → no `ReferenceError`
  in the console and the link still navigates.

**Verification:**
- Both CTAs open Calendly in a new tab and the originating page stays open.
- The event name observed is byte-identical across both CTAs.
- Console is clean on a page load and on a CTA click, with and without `fathom` defined.

---

- U2. **Build the 1200×630 Open Graph card**

**Goal:** Produce a card that reads as part of the site — its fonts, its blue, its headshot — at
exactly 1200×630, from a source that can be re-rendered later.

**Dependencies:** None.

**Files:**
- Create: `tools/og-image/og-card.html`
- Create: `assets/img/og-image.jpg`
- Modify: `_config.yml` (`exclude:` list only)

**Approach:**
- Author the card as a standalone HTML file with a viewport-exact 1200×630 root element: the headshot,
  `Chuck Blake`, and `Hands-on technical leadership for teams ready to ship`, on the site's palette
  (`#116dff`) with `Newsreader` for the name and `IBM Plex Mono` for the positioning line.
- Reference the headshot from `assets/img/prof_pic.jpg` — read-only, never modified. Do not use
  `prof_pic_color.png` (14 MB).
- Render at exactly 1200×630 and export to JPEG at high quality, checking the byte size against the
  ~150 KB budget and stepping quality down if needed. Verify the output is exactly 1200×630 — a
  scaled or letterboxed export defeats the whole issue.
- Add `tools/` to `_config.yml`'s `exclude:` so Jekyll does not publish the card source as a page.
  Follow the commented `plans/` entry as the precedent for annotating why a directory is excluded.

**Patterns to follow:**
- `_config.yml:203-224` `exclude:` list and its inline-comment style.

**Test scenarios:**
- Happy path: the exported file reports exactly `1200x630` dimensions.
- Happy path: the exported file is under ~150 KB.
- Edge case: text is legible at the ~500 px width that feed readers downscale previews to — the card
  must survive being shrunk, which is how most people will actually see it.
- Edge case: `git status` shows `assets/img/prof_pic.jpg` unmodified.
- Integration: `docker compose up --build` succeeds and the local site has no page at `/tools/` or
  `/tools/og-image/`, proving the `exclude:` entry took effect.

**Verification:**
- The card is regenerable from the in-repo HTML without re-deriving copy or colors.
- No claim appears on the card that is not already published on the site.

---

- U3. **Point the sitewide Open Graph tags at the new card**

**Goal:** Make every shared link render the new card, wide, on both Open Graph and Twitter consumers.

**Dependencies:** U2.

**Files:**
- Modify: `_config.yml` (`og_image:`)
- Modify: `_includes/metadata.liquid` (`twitter:card`)

**Approach:**
- Repoint `og_image:` to the new asset, keeping it a fully-qualified `https://chuckblake.com/...` URL.
  `_includes/metadata.liquid` emits this value raw, with no `absolute_url` filter, so a relative path
  would silently produce a broken preview — the failure would only show up on a third-party scraper,
  not in the local build.
- Change `twitter:card` from `summary` to `summary_large_image`.
- Leave the `page.og_image` override branches in `metadata.liquid` intact; per-page overrides stay
  available and out of scope.

**Patterns to follow:**
- `_includes/metadata.liquid:69-71, 78-80` — the existing `page.og_image or site.og_image` branches.

**Test scenarios:**
- Happy path: in the built HTML for `/`, `og:image` is the new absolute URL.
- Happy path: in the built HTML for `/`, `twitter:card` is `summary_large_image` and `twitter:image`
  is the new absolute URL.
- Happy path: the same holds for an interior page (e.g. `/fractional-cto/`), confirming this is
  sitewide and not just the home page.
- Edge case: the emitted URL has no double slash and no leading `/assets` relative form.
- Integration: fetching the emitted `og:image` path from the local build returns the image, proving
  the file actually lives where the config claims.

**Verification:**
- No page emits `prof_pic.jpg` as its `og:image` any more.
- `og:image` and `twitter:image` agree.

---

- U4. **Format and verify the full build**

**Goal:** Land the branch prettier-clean and confirm the rendered site is correct end to end.

**Dependencies:** U1, U2, U3.

**Files:**
- Modify: any files reformatted by prettier.

**Approach:**
- Run `npx prettier . --write` per AGENTS.md's pre-commit checklist. `.github/workflows/prettier.yml`
  and `prettier-html.yml` gate the PR, so an unformatted new `.js`, `.liquid`, `.md`, `.yml`, or
  `.html` file turns CI red on arrival.
- Confirm the new `tools/og-image/og-card.html` is either formatted or deliberately added to
  `.prettierignore` — decide one way; do not leave it ambiguous.
- Rebuild with `docker compose up --build` and check the site end to end.

**Test scenarios:**
- Happy path: `npx prettier . --check` reports no issues.
- Happy path: `docker compose up --build` completes without error.
- Integration: on the running local site, both CTAs fire the event and the head tags carry the new
  card — i.e. U1 and U3 verified together in one rendered build rather than in isolation.
- Edge case: dark mode renders unchanged (no CSS was touched, so this is a regression check).

**Verification:**
- Prettier is clean, the build succeeds, and the working tree contains no unintended reformatting of
  files unrelated to this branch.

---

## Post-merge verification (Chuck)

**Not implementation units. Not checklist items.** These need a live public URL or the Fathom
dashboard, neither of which exists on a branch, so they cannot gate this PR.

- **CSB-4 — card checker.** After deploy, run `chuckblake.com` through opengraph.xyz and LinkedIn Post
  Inspector and confirm a wide, uncropped card. LinkedIn caches aggressively; use the Inspector's
  re-scrape to bust it.
- **CSB-5 — first event.** Click a Calendly CTA on the live site once, then confirm
  `Calendly CTA clicked` appears in Fathom. Events auto-create on first fire, so nothing needs setting
  up beforehand — but nothing appears until a real click happens over https either.
- **CSB-5 — referrer breakdown.** Read Fathom's site-level Referrers report to see whether search
  engines and AI assistants are distinguishable. This is a provider-native observation, and its
  outcome is a property of what referrers those sources actually send — some AI assistants send none.
  No code in this plan can change that.

---

## System-Wide Impact

- **Interaction graph:** One new delegated `click` listener on `document`. It only reads the event and
  calls out to Fathom; it never calls `preventDefault()`, so no existing click behavior changes.
- **Error propagation:** The `typeof fathom` guard is the only failure boundary. A blocked CDN
  degrades to "no analytics", never to a broken link.
- **API surface parity:** `og:image` and `twitter:image` read the same config value, so they cannot
  drift. `twitter:card` is the one tag that must be changed in step with the image.
- **Unchanged invariants:** The Fathom install itself, every `_config.yml` analytics cell, the CSP,
  `assets/img/prof_pic.jpg`, and the per-page `og_image` override path are all explicitly unchanged.

---

## Risks & Dependencies

| Risk | Mitigation |
|------|------------|
| Tracking beacon lost to same-tab navigation | Both CTAs open in a new tab (U1), so the originating page stays alive |
| Ad blocker blocks the Fathom CDN | `typeof fathom` guard — link still works, console stays clean |
| `og_image` set to a relative path | Explicitly called out: `metadata.liquid` emits the raw value; local build cannot catch this, so it is a review checkpoint |
| New image pushes past ~150 KB | JPEG with a quality-step-down loop and an explicit byte check in U2 |
| Card source published as a site page | `tools/` added to Jekyll `exclude:`, verified by a build check in U2 |
| Prettier CI red on arrival | Explicit `npx prettier . --write` unit (U4) before commit |
| Wide card ships but X still renders small | `twitter:card` → `summary_large_image` in the same unit as the image repoint (U3) |

---

## Open Questions

### Resolved During Planning

- *Which analytics provider?* — Fathom. Already installed and live on `main`; a second provider would
  double-track. CSB-5's Pirsch recommendation predates the Fathom install.
- *Does Chuck need to create the event in Fathom first?* — No. Fathom auto-creates events on first
  fire, so CSB-5's stated "Chuck must create the analytics account" constraint does not gate this work.
- *`trackGoal` or `trackEvent`?* — `trackEvent`; `trackGoal` is deprecated for new events.
- *One event or one per CTA location?* — One. CSB-5's Scope says one goal, and event names are the
  aggregation unit, so splitting later is a one-way door on metric history.
- *Generative or HTML-rendered OG card?* — HTML-rendered, for exact typography and regenerability.

### Deferred to Implementation

- Exact JPEG quality setting needed to land under ~150 KB — depends on how the headshot compresses.
- Precise card layout (headshot placement, type scale) — a visual judgment best made while looking at
  the render, within the fixed palette and font constraints.
- Whether `tools/og-image/og-card.html` is prettier-formatted or `.prettierignore`d — decide once the
  file exists and its formatted shape is visible.

---

## Sources & References

- Backlog issues: CSB-5 (primary), CSB-4 — grouped via `plans/csb-5-feature-add-privacy-friendly-analytics.group.json`
- Prior art in-repo: commit `5243562` (Fathom install), `_includes/metadata.liquid`, `_includes/scripts.liquid`
- Fathom events: https://usefathom.com/docs/events/overview
- Fathom external-link tracking: https://usefathom.com/docs/events/external-clicks
