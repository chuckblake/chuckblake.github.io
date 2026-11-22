---
name: add-project
description: Add a project to chuckblake.com, or update one (description, screenshot, status, topics). Use when Chuck wants a project listed, moved to past, or refreshed.
---

# Add or update a project

Each project is one Markdown file in `_projects/`. The projects page (`_pages/projects.md`, served at `/projects/`) lists every published project as one row, built by `_includes/project_row.liquid`, and each row links to the project's own page. Do not edit the projects page to add a project.

## Add a project

1. Create `_projects/<n>_<slug>.md`, where `<n>` is the next unused number in the directory (the number only keeps the files in order).

   ```markdown
   ---
   layout: page
   title: Project Name
   description: One line, shown in the row and under the title on the project page
   img: assets/img/projects/project-name.jpg
   importance: 3
   category: current
   topics: [AI, Dev tools]
   ---

   What it is, who it is for, and a link to it. Two or three short paragraphs.
   ```

2. Fill in the front matter:
   - `category` decides the group; `current` and `past` also show as the status in the row. The page shows `current`, `music` and `past`, in that order (`display_categories` in `_pages/projects.md`). Any other value, such as `lab`, keeps the project off the list while its page still builds.
   - `importance` orders projects inside a category, lowest first.
   - `topics` are the labels in the row and what the filter buttons match. The buttons are the `filters` list in `_pages/projects.md` (`Current`, `AI`, `Music`, `Past`); a button matches a project whose category or one of whose topics has the same name. To add a filter, add its name to that list.
   - `published: false` hides a project completely.
   - `redirect: https://example.com` makes the row link to that address in place of the project page.
3. Add the screenshot as `assets/img/projects/<slug>.jpg`, 1200 × 750 px (the row crops it to 128 × 80, and the project page can show it full size). A project with no `img` gets a tile with its first letter, so leave `img` out sooner than point it at a missing file.
4. If the project belongs on the home page "Now" list, add a row to `_layouts/about.liquid`. Keep that list to four or five rows.

## Update a project

- New screenshot: replace the file under `assets/img/projects/`, keeping the name and the 1200 × 750 size.
- Finished or shut down: set `category: past`.
- New one-liner: change `description`.

## Check and publish

Run the checks in `AGENTS.md` (`bin/prettier --write .`, then `bin/site-check`), open a pull request, and release as described under "Publishing" in `AGENTS.md`.
