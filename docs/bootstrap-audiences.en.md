---
title: Audience Bootstraps
description: "Role-adapted onboarding for developers, devsecops, android early adopters, and stakeholders"
---

# Audience Bootstraps

Different audiences need different onboarding paths:

## 1. Developer (builder mode)

Goal: full local setup for fast code iteration.

```bash
./scripts/bootstrap.sh --role developer --profile full
source .venv/bin/activate
make build
make run
```

What it prepares:

- Ubuntu/Debian system prerequisites
- Local Python environment (`.venv`)
- Data structure (`data/`, `outputs/`)
- Full Docker stack (ingestor, pipeline, frontend, gitops)

## 2. DevSecOps (guardian mode)

Goal: hardening, validation, and software supply-chain controls.

```bash
./scripts/bootstrap.sh --role devsecops --profile full
source .venv/bin/activate
python -m pip_audit -r requirements.txt
```

What it adds:

- Security-focused validation toolchain
- Dependencies for compliance/security checks
- Local readiness for `ci-security` workflows

## Canonical VSCode profile (early-adopter UX)

For a consistent editor setup across the team:

- Use the versioned `.vscode/` workspace files
- Follow the guide: [VSCode for early adopters](vscode-tooling-setup.en.md)

## 3. Android Early Adopter (Termux)

Goal: mobile contribution with hybrid local/remote operation.

```bash
./scripts/bootstrap-android.sh --role developer --profile lite
source .venv-android/bin/activate
```

Notes:

- `lite` profile installs docs/validation/CLI essentials.
- For heavy workloads, use `DOCKER_HOST=ssh://...` with an Ubuntu host.

## 4. End User / Stakeholder (decision mode)

Goal: business value visibility with minimal technical friction.

```bash
./scripts/bootstrap-stakeholder.sh --lang en --run-demo
```

What it provides:

- Local demo setup using published images
- Fast defaults for quick evaluation
- Dashboard at `http://localhost:8501`

## Cross-audience smoke test

Validate bootstrap coherence in the current branch:

```bash
./test-bootstrap.sh
```

This verifies:

- Required script availability
- Shell syntax validity
- Safe dry-run execution for all three bootstrap flows
