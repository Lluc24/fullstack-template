# App

A monorepo template: FastAPI backend, React frontend, Supabase migrations, deployed on Vercel as one project.

```
make setup     # install everything, enable the pre-commit hook
make dev-api   # API on :8000
make dev-web   # page on http://localhost:5173, proxies /v1 to the API
make check     # format, lint, typecheck, build: the targets CI runs
make fix       # auto-format and auto-fix
```

Needs uv, pnpm and make.

## After "Use this template"

1. Rename `App`/`app-web`: this README, `frontend/index.html`, `frontend/src/App.tsx`, `frontend/package.json`, `backend/src/app/api.py`, and the first line of `AGENTS.md`.
2. `make setup`, then `make repo-bootstrap` once: squash-only merges, auto-deleted branches, the `main` ruleset. Rulesets on a private repo need a paid GitHub plan.
3. Create the Vercel project and connect this GitHub repo to it (Vercel's Git integration sends the events preview.yml and smoke.yml run on). The Vercel settings are under `[tool.vercel]` in `pyproject.toml`. Client-side routes need a rewrite to `/index.html` in a `vercel.json`.
4. In the GitHub repo settings: the variable `SITE_URL` (production URL, for smoke.yml), the secret `VERCEL_AUTOMATION_BYPASS_SECRET` (preview.yml gets 401 without it) and the secret `SUPABASE_DB_URL` (before the first migration).

## Layout

| Path | What |
| --- | --- |
| `backend/src/app/api.py` | FastAPI app, the `/v1` routes, serves the built page |
| `frontend/` | React site; `src/api.ts` is the typed client for `/v1` |
| `supabase/migrations/` | SQL migrations, applied on push to main |
| `.github/` | CI, preview and production checks, the `main` ruleset |

Rules: `AGENTS.md` in each directory, explained in [docs/CODING_RULES.md](docs/CODING_RULES.md). PR workflow: [CONTRIBUTING.md](CONTRIBUTING.md).
