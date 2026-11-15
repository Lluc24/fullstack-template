# CI/CD: GitHub Actions.
- CI jobs run the Makefile's check targets; change the checks there, not in the YAML.
- Required checks in rulesets/main.json are CI job ids: rename both together.
- Pin actions to a major version; Dependabot bumps them and all dependencies weekly.
- Secrets and variables: README, "After Use this template", step 4.
