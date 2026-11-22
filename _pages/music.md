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
  <h2 class="section-label">My music</h2>
  <div class="music-acts">
    <div class="music-act">
      <h3 class="music-act__name">Corvoco</h3>
      <p class="music-act__desc">Chill post-punk electronic music</p>
      <p class="music-act__links">
        <a href="https://open.spotify.com/artist/3m2iFDte1hP9QY4bEOjMtR">Spotify →</a>
        <a href="https://corvoco.bandcamp.com">Bandcamp →</a>
      </p>
      <iframe class="music-act__player" title="Corvoco on Spotify" src="https://open.spotify.com/embed/album/0uGXyXQfeknmW1LHdb07DZ" width="100%" height="352" frameborder="0" allowfullscreen allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>
    </div>
    <div class="music-act">
      <h3 class="music-act__name">Garlands</h3>
      <p class="music-act__desc">A band I played in</p>
      <p class="music-act__links">
        <a href="https://open.spotify.com/artist/3kNsb1sLtaGAWs91170G6c">Spotify →</a>
      </p>
      <iframe class="music-act__player" title="Garlands on Spotify" src="https://open.spotify.com/embed/album/08iEjEYnB6xY6US5BZ4EKW" width="100%" height="352" frameborder="0" allowfullscreen allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>
    </div>
  </div>

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
