.PHONY: setup check check-backend check-frontend fix dev-api dev-web repo-bootstrap

setup:
	uv sync --all-packages
	cd frontend && pnpm install
	git config core.hooksPath .githooks

check: check-backend check-frontend

check-backend:
	uv run ruff format --check
	uv run ruff check
	uv run mypy backend/src

check-frontend:
	cd frontend && pnpm check
	cd frontend && pnpm build

fix:
	uv run ruff format
	uv run ruff check --fix
	cd frontend && pnpm fix

# FASTAPI_ENV=development lets the API start before frontend/dist is built.
dev-api:
	FASTAPI_ENV=development uv run uvicorn app.api:app --reload

dev-web:
	cd frontend && pnpm dev

# Once, by a repo admin with gh logged in.
repo-bootstrap:
	gh repo edit --default-branch main --enable-squash-merge --squash-merge-commit-message pr-title-description --enable-merge-commit=false --enable-rebase-merge=false --delete-branch-on-merge --enable-auto-merge --allow-update-branch
	gh api -X POST 'repos/{owner}/{repo}/rulesets' --input .github/rulesets/main.json
