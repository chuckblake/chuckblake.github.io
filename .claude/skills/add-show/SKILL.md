---
name: add-show
description: Add a concert or live show to the music page of chuckblake.com, with or without a photo. Use when Chuck says he went to, or is going to, a show.
---

# Add a show

The music page (`_pages/music.md`, served at `/music/`) builds its grid from `_data/shows.yml`. Adding a show means adding one entry to that file and, when there is a photo, one image file. Do not edit `_pages/music.md` for this.

## Steps

1. Get the date, the artist, and the venue. Ask for whichever of the date or artist is missing; the venue is optional.
2. If there is a photo, save it as `assets/img/concerts/<artist-slug>-<year>.jpg` (for example `echo-bunnymen-2024.jpg`).
   - Resize it so the long edge is at most 1600 px and save as JPEG, quality about 82: `convert in.heic -auto-orient -resize '1600x1600>' -quality 82 out.jpg`.
   - Landscape works best: the grid crops every photo to 4:3 from the centre.
   - The build writes the responsive `.webp` copies itself. Do not commit them.
3. Add the entry to `_data/shows.yml`. The page sorts by date, so position in the file does not matter, but keep the file newest first for readability.

   ```yaml
   - date: 2026-11-14
     artist: "Artist Name & Support Act"
     venue: Brooklyn Steel
     photo: assets/img/concerts/artist-name-2026.jpg
   ```

   - `date` is `YYYY-MM-DD`, unquoted. A date after the build day gets an "Upcoming" label on the page.
   - Quote `artist` when it contains `&`, `:` or `#`.
   - Leave `venue` or `photo` out when there is none. A show without a photo gets a tile with the artist's name.

   - For more than one photo, use `photos:` with a list in place of `photo:`. The page then shows arrows to flip through them, first one first. Name the files `<artist-slug>-<year>.jpg`, `<artist-slug>-<year>-2.jpg` and so on.

     ```yaml
     photos:
       - assets/img/concerts/artist-name-2026.jpg
       - assets/img/concerts/artist-name-2026-2.jpg
     ```

   - When Chuck sends a video, take one sharp, well-lit frame from it as the photo: `ffmpeg -ss <seconds> -i in.mov -frames:v 1 -q:v 2 -vf "scale=1600:-2" out.jpg`. The video's creation date is the show date.
   - Phone photos that come through chat usually have their date stripped. Match them by what is visible (venue signs, a band name on a drum or screen) and by camera-roll order against dated shows, and tell Chuck which matches are inferred.
   - Crop out audience members whose faces are clearly visible in the foreground.

4. To add a photo to a show that is already listed, add the image file and the `photo:` line to its entry.
5. Run the checks in `AGENTS.md` (`bin/prettier --write .`, then `bin/site-check`), open a pull request, and release as described under "Publishing" in `AGENTS.md`.
