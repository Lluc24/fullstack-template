# Contributing
- Never push to main. Branch from main as `<type>/<short-description>`, e.g. `feat/health-endpoint`.
- PR title is a Conventional Commit (`feat(api): add health endpoint`); it becomes the squash commit on main.
- `make check` passes locally (pre-commit hook) and in CI. CI must be green.
- No approval required; reviews are optional, but resolve every review thread opened. Merge = squash only; the branch is deleted.
- Repo settings live in .github/rulesets and `make repo-bootstrap`; change them there, not in the UI.
