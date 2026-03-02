# Disabled Features

The following features from the original managed.com / DotNetNuke (DNN) site have been **disabled or removed** in this static rebuild. Each is noted with rationale and the recommended replacement approach where applicable.

---

## 1. DNN User Registration & Login System
**Original:** `/register` and `/login` — a full DotNetNuke user account system requiring server-side .NET processing, database, and email verification.

**Status:** ❌ Removed

**Replacement:** `register.html` now provides a simple mailing list sign-up form powered by [Formspree](https://formspree.io/f/xwvndkow). Members no longer need accounts — the site is fully public.

---

## 2. DNN SuperForm Contact Form (with CAPTCHA)
**Original:** `/contact-us` — a DNNSmart SuperForm module with jQuery Validation Engine, CAPTCHA image, server-side email processing, and DNN-specific UI components.

**Status:** ❌ Removed

**Replacement:** `contact.html` uses a clean HTML form posting to [Formspree](https://formspree.io/f/xwvndkow) with a honeypot field for basic spam protection. Formspree handles delivery to your email inbox.

---

## 3. Site-Wide Search
**Original:** A search icon in the top-right header that triggered a DNN full-text search across the CMS.

**Status:** ❌ Removed

**Rationale:** Static sites do not support server-side search natively. If needed in future, consider [Pagefind](https://pagefind.app) (runs at build time, zero runtime cost) or [Algolia DocSearch](https://docsearch.algolia.com).

---

## 4. DNN Admin / "Add Content…" Interface
**Original:** An "Add Content…" inline editing button was visible on the News page (and possibly others) for logged-in admins.

**Status:** ❌ Removed

**Replacement:** Edit content directly in the HTML files and push to GitHub. GitHub Pages will re-deploy automatically.

---

## 5. User Portal / Members Area
**Original:** Logged-in users could access a private members area (referenced in the Register flow).

**Status:** ❌ Removed

**Rationale:** No equivalent feature planned for the static site. If private content is needed in future, consider [Netlify Identity](https://docs.netlify.com/visitor-access/identity/) or a separate password-protected page.

---

## 6. Diary — Live Google Sheets Integration (Planned)
**Original:** Static HTML content manually updated in the CMS.

**Status:** 🔄 Planned — currently static HTML

**Planned approach:** Publish the diary as a Google Sheet CSV and fetch it with JavaScript at page load. See `diary-from-sheets.md` for step-by-step instructions.

---

## Summary Table

| Feature | Original | Status | Replacement |
|---|---|---|---|
| User registration | DNN accounts | ❌ Removed | Formspree mailing list |
| Login | DNN auth | ❌ Removed | Not needed (public site) |
| Contact form | DNN SuperForm + CAPTCHA | ❌ Removed | Formspree + honeypot |
| Site search | DNN full-text search | ❌ Removed | Pagefind (future) |
| Admin inline editing | DNN CMS | ❌ Removed | Edit HTML + git push |
| Members area | DNN user portal | ❌ Removed | Not planned |
| Diary live data | Static CMS | 🔄 Planned | Google Sheets CSV |
