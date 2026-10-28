# Veloo

Veloo is a personal workspace for reading research papers. Paper analysis, English-to-Korean translation, terminology lookup, and architecture-explanation practice live under one login, with history saved per account.

![Illustration of research papers and charts connected in a workspace](web/public/marketing/hero-research.png)

## Quick start

You need Docker, a Supabase project, and an Anthropic API key.

1. In the repository root, create `.env` with `SUPABASE_URL`, `SUPABASE_KEY`, and `ANTHROPIC_API_KEY`.
2. Run [`server/schema.sql`](server/schema.sql) in the Supabase SQL Editor.
3. From the repository root, build and run:

   ```bash
   docker build -t veloo .
   docker run --env-file .env -p 9000:9000 veloo
   ```

4. Open <http://localhost:9000/> and register. In Supabase, set your account’s `is_approved` to `true` in the `users` table, then sign in.
5. Open Translator and paste an English sentence from a paper to get a streamed Korean translation.

## Documentation

- [Feature walkthroughs](docs/features.md)
- [Technical design and environment variables](docs/design.md)
- [Documentation index and capability specs](docs/README.md)
- [UI design system](docs/ui-design-system.md)
- [Changelog](CHANGELOG.md)

## License

[MIT](LICENSE) © 2026 jwhitekim
