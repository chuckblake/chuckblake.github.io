---
layout: page
title: Music
permalink: /music/
description: "A personal archive of live shows and electronic music"
meta_description: "Browse Chuck Blake's live show history and concert photos, plus Corvoco, his electronic music project, for a personal view beyond technology and startups."
nav: true
nav_order: 3
---

<!-- Shows come from _data/shows.yml. To add one see .claude/skills/add-show/SKILL.md -->
<div class="music">
  <a class="music-feature" href="https://corvoco.bandcamp.com">
    <img class="music-feature__img" src="{{ 'assets/img/projects/corvoco.jpg' | relative_url }}" alt="" width="200" height="125" loading="eager">
    <span class="music-feature__body">
      <span class="section-label">My music</span>
      <span class="music-feature__name">Corvoco</span>
      <span class="music-feature__desc">Chill post-punk electronic music</span>
    </span>
    <span class="music-feature__cta">Listen on Bandcamp →</span>
  </a>

  <h2 class="section-label">Shows</h2>
  <div class="show-grid">
    {% assign now = site.time | date: "%s" | plus: 0 %}
    {% assign shows = site.data.shows | sort: "date" | reverse %}
    {% for show in shows %}
      {% assign show_time = show.date | date: "%s" | plus: 0 %}
      <div class="show-card">
        {% if show.photo %}
          {% include figure.liquid loading="lazy" path=show.photo sizes="(min-width: 992px) 330px, 95vw" alt=show.artist zoomable=true %}
        {% else %}
          <div class="show-card__tile" aria-hidden="true"><span>{{ show.artist }}</span></div>
        {% endif %}
        <p class="show-card__artist">{{ show.artist }}</p>
        <p class="show-card__meta">
          {% if show_time > now %}<span class="show-card__upcoming">Upcoming</span> · {% endif %}{{ show.date | date: "%b %-d, %Y" }}{% if show.venue %} · {{ show.venue }}{% endif %}
        </p>
      </div>
    {% endfor %}
  </div>
</div>
