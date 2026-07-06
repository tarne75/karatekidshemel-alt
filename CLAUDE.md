# CLAUDE.md — Project Notes for karatekidshemel

This file records what has been done to this repository so Claude (and humans) have context in future sessions.

---

## Project Overview

Static website for **Karate Kids Hemel / Sasori Karate Dojo**, rebuilt from the original DotNetNuke (managed.com) CMS and migrated to **GitHub Pages**.

- **Live site (original):** https://www.karatekidshemel.co.uk
- **GitHub remote:** git@github.com:tarne75/karatekidshemel-alt.git
- **Target hosting:** GitHub Pages (root of `main` branch)

---

## Session 1 — Initial Rebuild (March 2026)

### What was done

**Full site redesign and static rebuild** from the DotNetNuke CMS to plain HTML/CSS/JS, ready for GitHub Pages.

#### Pages built
| File | Page | Key content |
|---|---|---|
| `index.html` | Home | Hero, training schedule cards, about/welcome, Dojo Kun principles, pricing |
| `history.html` | History | Club history from 1980, Japan trips, prose article layout |
| `instructors.html` | Instructors | Photo + bio cards for Chris Green, Marie Green, Dean Smith |
| `training.html` | Training | Kids and adult classes, schedule, equipment info |
| `diary.html` | Diary | 2026 event calendar (currently static — see Google Sheets note below) |
| `benefits.html` | Benefits | 6 benefit cards (confidence, concentration, fitness, self-defence, motivation, well-being) |
| `news.html` | News | Jujitsu seminar announcement, 2025 trophy winners |
| `contact.html` | Contact Us | Formspree contact form + location info for both venues |
| `register.html` | Register | Mailing list sign-up form via Formspree |

#### Shared assets
- `assets/css/style.css` — 787-line design system: CSS custom properties, Oswald + Inter fonts, mobile-first responsive layout
- `assets/js/main.js` — Mobile nav toggle + Formspree AJAX helper
- `assets/images/` — **Empty** — images must be downloaded (see below)

#### Supporting files
- `.nojekyll` — Prevents GitHub Pages from running Jekyll
- `DISABLED_FEATURES.md` — Documents every DNN feature removed/disabled
- `diary-from-sheets.md` — Step-by-step guide for wiring diary to Google Sheets
- `download-images.sh` — Shell script to fetch images from the live site

### Design system
- **Colours:** Deep red `#C0141C`, black `#0A0A0A`, white — martial arts aesthetic matching the Sasori scorpion logo
- **Fonts:** Oswald (headings/display) + Inter (body) — loaded from Google Fonts
- **Layout:** CSS Grid + Flexbox, mobile hamburger nav, sticky header, full footer with schedule
- **No frameworks** — vanilla HTML/CSS/JS only

### Dynamic behaviour
| Feature | Approach |
|---|---|
| Contact form | Formspree `https://formspree.io/f/xwvndkow` |
| Mailing list registration | Same Formspree endpoint, tagged with `form_type: mailing_list` |
| Spam protection | Honeypot `_gotcha` field on both forms |
| Form submission | AJAX via `setupFormspree()` in `main.js` — no page reload |

### Disabled/removed from original site
See `DISABLED_FEATURES.md` for full detail. Summary:
- DNN user registration & login (replaced by Formspree mailing list)
- DNNSmart SuperForm contact form with CAPTCHA (replaced by Formspree)
- Site-wide full-text search (removed — consider Pagefind in future)
- DNN admin inline editing (edit HTML files directly and push)
- Members area / user portal (not planned)

---

## Session 2 — Instructor photo fix (March 2026)

**Problem:** On the live GitHub Pages site, the instructor photos for Chris and Marie were cropping their heads off.

**Root cause:** All three instructor photos are landscape (585×390px) shot in the same dojo room. The subject (instructor) stands in the **right half** of the frame; the left half is decorative shelf/background. The CSS had `object-position: top` which anchored the crop to the top-centre of the image — landing on the shelf, not the person.

**Fix:** Changed `object-position: top` → `object-position: right top` in `.instructor-card img` rule in `assets/css/style.css`. This anchors the crop to the top-right of each image, correctly framing all three instructors.

**Convention going forward:** CLAUDE.md should be updated after every change made to this project.

---

## Session 3 — Favicon / icons (March 2026)

**What was done:** Added a full favicon set to all pages so the site has a browser tab icon.

**Files added:**
| File | Description |
|---|---|
| `favicon.ico` | Multi-size ICO (16×16, 32×32) for broad browser compatibility |
| `favicon.svg` | SVG favicon — red scorpion on black, matches brand colours |
| `favicon-16x16.png` | 16px PNG fallback |
| `favicon-32x32.png` | 32px PNG fallback |
| `apple-touch-icon.png` | 180×180px PNG for iOS home-screen bookmarks |

**Pages updated:** All 9 HTML pages (`index.html`, `benefits.html`, `contact.html`, `diary.html`, `history.html`, `instructors.html`, `news.html`, `register.html`, `training.html`) — `<link>` tags added to each `<head>`.

**SVG design:** Scorpion silhouette in white (`#FFFFFF`) on a deep red (`#C0141C`) square with rounded corners, consistent with the site's martial arts aesthetic.

---

## Session 4 — Diary wired to Google Sheets (July 2026)

**What was done:** Replaced the static diary table in `diary.html` with a live fetch from a published Google Sheet CSV.

**Live CSV URL:**
```
https://docs.google.com/spreadsheets/d/e/2PACX-1vRC_oM_iSkcLNCavPm2jHFYnGFGTqUc6Ii-5UuhxEc-APqFYWMufy3OS4trB1PoVTZllInCVc7rIT0j/pub?gid=0&single=true&output=csv
```

**How it works:**
- On page load, an async `fetch()` call retrieves the CSV from the published Google Sheet.
- A lightweight inline CSV parser handles quoted fields (including events that contain commas).
- The header row is parsed to locate column positions; remaining rows are rendered as `<tr>` elements.
- Past events (whose end date is before today) are automatically greyed out via the `.diary-past` CSS class.
- An optional **Status** column is supported — set any row's Status cell to `hide` to suppress it from the page entirely.
- If the fetch fails, a graceful fallback message is shown instead.
- The static rows and the `TODO` comment were removed from `diary.html`.
- The diary note ("Please note all these dates…") is retained as static HTML above the table.

**Google Sheet columns:**
| Column | Required | Notes |
|---|---|---|
| Date | Yes | DD/MM/YYYY format, e.g. `5/1/2026` or `11/07/2026` |
| Event | Yes | Event description |
| Status | No | Set to `hide` to suppress the row |

Column order in the sheet does not matter — the JS reads the header row and maps by name.

**Date display:** Dates are reformatted from `DD/MM/YYYY` to a readable form, e.g. `5/1/2026` → `5 Jan 2026`.

**Past-event greying:** The JS parses the Date field and compares it to today. Events whose date has passed get the `.diary-past` class (60% opacity, grey text, no hover highlight).

**To update the diary going forward:** Edit the Google Sheet — no code changes needed. The site will reflect changes on next page load.

**Files changed:** `diary.html`, `assets/css/style.css`

---

## Outstanding tasks

- [ ] **Download images** — run `bash download-images.sh` from project root, then `git add assets/images/ && git commit`
- [ ] **Push to GitHub** — `git push origin main`, then enable GitHub Pages in repo settings (Source: `main` branch, root `/`)
- [x] **Diary → Google Sheets** — completed in Session 4
- [ ] **Domain** — point `karatekidshemel.co.uk` DNS to GitHub Pages (CNAME record to `tarne75.github.io`, add `CNAME` file to repo root containing `karatekidshemel.co.uk`)

---

## Image assets (to be downloaded)

| File | Source URL | Description |
|---|---|---|
| `assets/images/logo.jpg` | `https://karatekidshemel.co.uk/Portals/0/sasorilogo.jpg` | Sasori scorpion logo |
| `assets/images/chris.jpg` | `https://karatekidshemel.co.uk/portals/0/B37562D0F8794B7B8CE6FF632A76CDF0.jpg` | Shihan Chris Green |
| `assets/images/marie.jpg` | `https://karatekidshemel.co.uk/portals/0/BEBF21CB1D024ED4948757ABA6536A24.jpg` | Shihan Marie Green |
| `assets/images/dean.jpg` | `https://karatekidshemel.co.uk/portals/0/0002C2CA64E84FC7A01E547A236FBD4F.jpg` | Sensei Dean Smith |

---

## Useful commands

```bash
# Download images from live site (run from project root on your machine)
bash download-images.sh

# Serve locally to preview
python3 -m http.server 8765

# Push to GitHub
git push origin main
```
