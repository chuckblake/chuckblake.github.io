---
layout: page
permalink: /blog/
title: Blog
description: "New writing now lives on Substack"
meta_description: "Explore Chuck Blake's essays on startups, technology, music, AI systems, and developer tools, written from a founder and fractional CTO's perspective."
nav: false
---

<!-- The blog is off the menu: new writing goes to Substack. This page stays so old /blog/ links and the posts below keep working. -->
<div class="blog-archive">
  <p>
    I now write at <a href="https://ingeneral.substack.com/">In General on Substack</a>. The essays first published here are still available:
  </p>
  <div>
    {% for post in site.posts %}
      <a class="home-row" href="{{ post.url | relative_url }}">
        <span class="home-row__name">{{ post.date | date: "%b %-d, %Y" }}</span>
        <span class="home-row__desc">{{ post.title }}</span>
      </a>
    {% endfor %}
  </div>
</div>
