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

## Outstanding tasks

- [ ] **Download images** — run `bash download-images.sh` from project root, then `git add assets/images/ && git commit`
- [ ] **Push to GitHub** — `git push origin main`, then enable GitHub Pages in repo settings (Source: `main` branch, root `/`)
- [ ] **Diary → Google Sheets** — see `diary-from-sheets.md` for integration guide
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
