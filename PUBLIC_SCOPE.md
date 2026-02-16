# Public Scope Manifest

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

## Notes

- This export intentionally removes internal business/policy/process logic.
- Re-run `scripts/generate-public-cognitive-suite-repo.sh` to regenerate.
