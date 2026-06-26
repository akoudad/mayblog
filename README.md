# mayblog

My personal blog — writing on AI/ML, mostly things I rebuild from scratch to understand them.

**Live:** https://mayblog-9e9.pages.dev

Static site built with [Astro](https://astro.build), deployed on Cloudflare Pages (auto-deploys on push to `main`).

## Develop

```sh
npm install
npm run dev      # http://localhost:4321
npm run build    # output to ./dist/
```

## Writing

Add a Markdown file to `src/content/blog/`:

```md
---
title: 'Post title'
description: 'One-line summary.'
pubDate: 2026-06-27
---

Body in Markdown.
```

Commit and push — it's live in about a minute.
