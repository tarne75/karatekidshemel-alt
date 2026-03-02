# Diary — Google Sheets Integration Guide

This guide explains how to replace the static diary table in `diary.html` with live data fetched from a Google Sheet.

## Step 1 — Create the Google Sheet

Create a Google Sheet with two columns:

| Date | Event |
|---|---|
| 5–8 Jan | Classes re-start after the Christmas break |
| 31 Jan | Jujitsu seminar with Shihan Ben Craft (adults and brown belts only) |
| … | … |

## Step 2 — Publish to the Web

1. In Google Sheets, go to **File → Share → Publish to web**
2. Select the sheet tab and choose **Comma-separated values (.csv)**
3. Click **Publish** and copy the URL — it will look like:
   ```
   https://docs.google.com/spreadsheets/d/SHEET_ID/pub?gid=0&single=true&output=csv
   ```

## Step 3 — Replace the static table in diary.html

Replace the `<table class="diary-table">...</table>` block with:

```html
<div style="overflow-x:auto;">
  <table class="diary-table" id="diary-table">
    <thead>
      <tr><th>Date</th><th>Event</th></tr>
    </thead>
    <tbody id="diary-body">
      <tr><td colspan="2" style="padding:1.5rem; color:var(--gray);">Loading diary…</td></tr>
    </tbody>
  </table>
</div>

<script>
(async () => {
  const SHEET_CSV_URL = 'https://docs.google.com/spreadsheets/d/SHEET_ID/pub?gid=0&single=true&output=csv';
  try {
    const res  = await fetch(SHEET_CSV_URL);
    const text = await res.text();
    const rows = text.trim().split('\n').slice(1); // skip header row
    const tbody = document.getElementById('diary-body');
    tbody.innerHTML = rows.map(row => {
      const [date, ...rest] = row.split(',');
      const event = rest.join(',').replace(/^"|"$/g, ''); // handle commas in event text
      return `<tr><td class="date-col">${date.replace(/^"|"$/g,'')}</td><td>${event}</td></tr>`;
    }).join('');
  } catch (e) {
    document.getElementById('diary-body').innerHTML =
      '<tr><td colspan="2" style="color:var(--gray);">Unable to load diary. Please check back later.</td></tr>';
  }
})();
</script>
```

## Notes

- The fetch will work in modern browsers. GitHub Pages serves over HTTPS, which is required.
- Google Sheets CSV is publicly readable with no API key needed once published.
- Update the diary simply by editing the Google Sheet — no code changes required.
- Replace `SHEET_ID` with the actual ID from your Google Sheet URL.
