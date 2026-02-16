---
layout: page
title: projects
permalink: /projects/
description: Things I'm building
nav: true
nav_order: 2
horizontal: false
---

<!-- pages/projects.md -->
<div class="projects">
  <!-- First row: Work projects (LEA) -->
  {% assign work_projects = site.projects | where: "category", "work" | sort: "importance" %}
  <div class="row row-cols-1 row-cols-md-3">
    {% for project in work_projects %}
      {% include projects.liquid %}
    {% endfor %}
  </div>

  <!-- Second row: Side projects -->
  {% assign side_projects = site.projects | where: "category", "side" | sort: "importance" %}
  <div class="row row-cols-1 row-cols-md-3">
    {% for project in side_projects %}
      {% include projects.liquid %}
    {% endfor %}
  </div>
</div>
