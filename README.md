# Veloo

Veloo is a personal workspace for reading research papers. Paper analysis, English-to-Korean translation, terminology lookup, and architecture-explanation practice live under one login.

[Open Veloo](https://veloo.2joon.com/) — private beta; accounts are approved manually.

![Illustration of research papers and charts connected in a workspace](web/public/marketing/hero-research.png)

## Features

- **Paper Analyzer** — upload a PDF or search by title or supported URL for an AI summary, Semantic Scholar metadata, and SJR journal indicators when the venue matches
- **Translator** — streamed English-to-Korean translation, instructed to preserve formulas, proper nouns, and selected ML/DL terms
- **Contextor** — meanings of a word or phrase grouped by ML/DL context
- **Model Review** — explain an architecture diagram and get AI grading against a reference explanation

Each tool keeps its own history per account. Walkthroughs are in [docs/features.md](docs/features.md).

## Self-hosting

You need Docker, a Supabase project, and an Anthropic API key (or Gemini with `AI_PROVIDER=gemini`).

1. Copy [`.env.example`](.env.example) to `.env` and set `SUPABASE_URL`, `SUPABASE_KEY`, and `ANTHROPIC_API_KEY` (for Gemini: `AI_PROVIDER=gemini` and `GEMINI_API_KEY`). `SUPABASE_SERVICE_KEY` and `S2_API_KEY` are optional.
2. Run [`server/schema.sql`](server/schema.sql) in the Supabase SQL Editor.
3. Build and run:

   ```bash
   docker build -t veloo .
   docker run --env-file .env -p 9000:9000 veloo
   ```

4. Open <http://localhost:9000/> and register, then set your account's `is_approved` to `true` in the `users` table.

The SMTP entries in `.env.example` belong to a removed module. Gemini streaming and image input are not fully verified yet ([design notes](docs/design.md)).

## Local development

You also need Python and Node.js (the Dockerfile uses 3.11 and 20). After steps 1–2 above, build the frontend first — the backend serves `web/dist`.

```bash
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
(cd web && npm ci && npm run build)
python -m server.main
```

For frontend work, run `npm run dev` in `web/` and open <http://localhost:5173/>. Vite proxies to port 9000.

## Documentation

- [Feature walkthroughs](docs/features.md) · [Docs index](docs/README.md)
- [API and product specs](docs/specs/) · [UI design system](docs/ui-design-system.md)
- [Changelog](CHANGELOG.md)

## License

[MIT](LICENSE) © 2026 jwhitekim
