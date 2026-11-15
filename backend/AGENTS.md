# Backend: Python 3.13, uv, FastAPI. One package `app` in src/app/.
Imports point inward only: domain.py ← adapters (one module per external service) ← application.py ← api.py.
- domain.py: types and business rules. Pure and sync: no I/O, no framework imports.
- Adapters: the only code that talks to their service. Parse every response with Pydantic into domain types. Explicit timeouts. Turn transport and parse failures into domain exceptions.
- db.py: only maps rows to domain types and back; takes `now`, never reads the clock.
- application.py: orchestrates each use case and reads the clock once, passing `now` down.
- api.py: the FastAPI composition root, HTTP concerns only: routes, status mapping, cache headers. Thin handlers, one pydantic-settings object, no os.environ elsewhere. Public routes live under /v1.
- Full type annotations, `mypy --strict` clean. Ruff and mypy config: root pyproject.toml.
