# Public Scope Contract

This export is a public-ready snapshot of the Cognitive Suite codebase.

## Included

- Core product components: `ingestor/`, `pipeline/`, `frontend/`, `cogctl.py`
- Public documentation: `docs/` excluding internal/private sections
- Public CI/release workflows subset in `.github/workflows/`
- Public validation scripts:
  - `scripts/validate-knowledge.py`
  - `scripts/validate-knowledge-uat.py`
  - `scripts/validate-stakeholder-intake.py`
  - `scripts/verify/*`
- Data contracts/schemas suitable for public reference

## Excluded

- Internal governance/process and private operations:
  - `docs/internal/`
  - internal runbooks and migration tooling
  - private ops automation and bot governance internals
- Sensitive/private organizational material and local artifacts:
  - `inputs/`, `credentials/`, `outputs/`, `evidence/`, `metrics/`
  - `bash/GitDevSecDataAIOps/`, `governance/`, `ops/`, `gitops/repo-governance/`
- Collaboration-specific internal docs for non-public governance approvals

## Explicitly Restricted Content

The following must not be introduced in public PRs to `main`:

- Internal operating method details and private runbooks.
- Contractual pricing templates and private negotiation playbooks.
- Internal process routing, proprietary governance internals, or sensitive customer data.
- Sensitive keywords/patterns enforced by public-scope CI guardrails.

## Controlled Public Exceptions

- `metrics/engagement/**` is allowed for public engagement governance.
- `outputs/ci-evidence/**` is allowed only for sanitized CI validation evidence.

## Enforcement

This contract is enforced by:

- Workflow: `.github/workflows/public-scope-guard.yml`
- Script: `scripts/verify/public_scope_guard.py`

The guard validates changed files on PRs to `main` and fails on blocked paths/keywords.

## Notes

- This export intentionally removes internal business/policy/process logic.
- Re-run `scripts/generate-public-cognitive-suite-repo.sh` to regenerate.
