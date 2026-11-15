# Monorepo (backend, frontend, supabase). Replace this line with what the product does.
Read the AGENTS.md of every directory you touch. Full rationale, only if a rule is unclear: docs/CODING_RULES.md.
- Validate untrusted input once, at the boundary, into typed domain values. Interior code trusts its types: no None/isinstance/hasattr checks, no impossible branches.
- Make invalid states unrepresentable: frozen dataclasses, enums, branded types. No raw dicts/JSON past the boundary, no Optional after validation.
- Fail loud: never catch to return None or a default, never swallow or log-and-continue. Errors propagate to the layer that can act.
- No guard returns: never `if not x: return None` up front. Write `if x:` around the work and put the single `return None` last.
- Start simple: make it work in the simplest shape first. Add a layer, queue, table or abstraction only when concrete code needs it. Dependencies point inward only.
- One function, one job. Names say what it is, with units (`retry_delay_seconds`). Booleans are predicates. No abbreviations except id, url, db.
- No AI slop: comments default to zero (only why, Pre/Post contracts, references; no narration, TODO excuses or commented-out code). Smallest diff that solves the task. No unrequested files, abstractions, fallbacks, docs, summaries or emoji. Agent files stay ≤ 10 lines.
- No tests: do not write or add any. Before committing: `make check` passes. Never push to main: branch and PR per CONTRIBUTING.md. Never commit secrets. PRs: plain English, ≤ 15 lines: a one-line summary, a What section, a Why section, nothing else.
