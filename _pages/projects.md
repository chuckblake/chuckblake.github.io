---
layout: page
title: Projects
permalink: /projects/
description: "Products, tools, and experiments from current and past work"
meta_description: "Explore Chuck Blake's current and past projects, including Arwen, Glance, GetMusic.fm, and IndieCrates, across developer tools and music."
nav: true
nav_order: 1
display_categories: [current, music, past]
filters: [Current, AI, Music, Past]
---

<!-- One row per project, from _projects/. To add or change a project see .claude/skills/add-project/SKILL.md -->
<div class="projects">
  <div class="row-filters" role="group" aria-label="Filter projects">
    <button type="button" class="row-filter is-active" data-filter="all" aria-pressed="true">All</button>
    {% for filter in page.filters %}
      <button type="button" class="row-filter" data-filter="{{ filter | slugify }}" aria-pressed="false">{{ filter }}</button>
    {% endfor %}
  </div>
  <div class="project-rows">
    {% for category in page.display_categories %}
      {% assign categorized_projects = site.projects | where: "category", category %}
      {% assign sorted_projects = categorized_projects | sort: "importance" %}
      {% for project in sorted_projects %}
        {% include project_row.liquid %}
      {% endfor %}
    {% endfor %}
  </div>
</div>

<script>
  (function () {
    var buttons = document.querySelectorAll(".row-filter");
    var rows = document.querySelectorAll(".project-row");
    buttons.forEach(function (button) {
      button.addEventListener("click", function () {
        var filter = button.getAttribute("data-filter");
        buttons.forEach(function (other) {
          var active = other === button;
          other.classList.toggle("is-active", active);
          other.setAttribute("aria-pressed", active ? "true" : "false");
        });
        rows.forEach(function (row) {
          var tags = row.getAttribute("data-tags").split(" ");
          row.hidden = filter !== "all" && tags.indexOf(filter) === -1;
        });
      });
    });
  })();
</script>
