# Atlantyqa Universe

Control-plane para gobernar el ecosistema cognitive-suite en modelo multi-repo, multi-forge y local-first.

Onboarding rapido para colaboradores: `GET-STARTED.md`

## Contexto actual

- repositorio control-plane: `atlantyqa-universe`
- rama por defecto remota: `main`
- repositorio publico generado: `https://github.com/atlantyqa-labs/cognitive-suite`
- colaboracion operativa: L0KY + inno

## Objetivo conjunto (L0KY + inno)

Construir una base unica de conocimiento y ejecucion para:

1. gobernar organizaciones, proyectos y repositorios (GitHub, GitLab, Gitea y otros)
2. integrar frontend, backend, data, operaciones y UX/UI bajo GitOps
3. convertir `inputs/repositories/**` en portfolio trazable de proyectos fuente
4. producir outputs publicables y auditables, sin exponer logica interna sensible
5. operar con soberania tecnica (bare-metal Ubuntu, microk8s, nube privada y evolucion web3)

## Diagnostico forense SCA (2026-02-16)

Reporte completo: `docs/internal/sca-forensic-diagnostic-2026-02-16.md`

Resultado ejecutivo:

- Python SCA (`pip-audit`) sobre 14 manifests: `0` vulnerabilidades conocidas
- Node SCA (`npm audit`) sobre 2 lockfiles: `0` vulnerabilidades conocidas
- paridad root/export (`requirements*` y `package-lock.json`): `MATCH`
- incidencia observada (`Failed to upgrade pip`) diagnosticada como problema de entorno/cache/red, no como hallazgo CVE

Evidencia en:

- `outputs/sca-forensic/requirements.txt.pip-audit.json`
- `outputs/sca-forensic/requirements-ci.txt.pip-audit.json`
- `outputs/sca-forensic/requirements-docs.txt.pip-audit.json`
- `outputs/sca-forensic/frontend_requirements.txt.pip-audit.json`
- `outputs/sca-forensic/ingestor_requirements.txt.pip-audit.json`
- `outputs/sca-forensic/pipeline_requirements.txt.pip-audit.json`
- `outputs/sca-forensic/pipeline_requirements-playground.txt.pip-audit.json`
- `outputs/sca-forensic/frontend_ux-prototype.npm-audit.json`

## Metodo de gobierno operativo

### Fase 1: Intake y clasificacion

- cada repositorio en `inputs/repositories/**` se registra en:
  - `gitops/repo-governance/plans/inputs-project-registry.tsv`
- se clasifica por:
  - dominio funcional
  - sensibilidad
  - cumplimiento
  - estado de adopcion

### Fase 2: Contratos y ontologia

- contratos activos:
  - `knowledge/contracts/view-contracts.yml`
  - `knowledge/contracts/inputs-project-portfolio-governance.yml`
- ontologia activa:
  - `knowledge/datasets/taxonomy.ontology.yml`

### Fase 3: Validacion tecnica y de conocimiento

Gates obligatorios (no negociables):

```bash
bash scripts/e2e-local-validation.sh

python3 scripts/validate-knowledge-uat.py \
  --contracts knowledge/contracts/view-contracts.yml \
  --ontology knowledge/datasets/taxonomy.ontology.yml \
  --sectors docs/sectors/sector-hub.md \
  --sectors-en docs/sectors/sector-hub.en.md

python3 scripts/validate-knowledge-uat.py
```

### Fase 4: SCA forense y evidencia

Ejecutar SCA con cache dedicada para evitar ruido de cache legacy:

```bash
bash scripts/sca-forensic-audit.sh
cat outputs/sca-forensic/summary.tsv
```

### Fase 5: PR governance y release discipline

- cambios por PR con evidencia adjunta
- release candidate en estado draft hasta cierre de riesgos
- decision de waiver o bloqueo documentada en minuta tecnica

### Fase 6: Distribucion multi-forge

- roadmap de olas:
  - `gitops/repo-governance/plans/forge-distribution-wave-1.tsv`
- estrategia operativa:
  - `docs/internal/draft-release-monorepo-refactor-playbook.md`

## Dominios de gobierno colaborativo

- frontend
- backend
- data
- operaciones
- ux/ui
- organizacional
- normativo/legal
- marketing y transferencia de conocimiento
- cognitivo

## Mapa rapido del repositorio

| Ruta | Funcion |
| --- | --- |
| `docs/` | Documentacion funcional, tecnica y de gobernanza |
| `knowledge/` | Contratos, ontologias y esquemas de conocimiento |
| `gitops/` | Planes y artefactos de gobierno operativo |
| `inputs/` | Fuentes de portfolio y repositorios externos a gobernar |
| `outputs/` | Evidencia de validaciones y diagnosticos |
| `scripts/` | Automatizaciones de validacion, SCA y bootstrap |
| `exports/public-repos/` | Exportes publicables sanitizados |

## Artefactos clave de colaboracion L0KY

- `docs/internal/loky-collaboration-governance-model.md`
- `docs/internal/draft-release-monorepo-refactor-playbook.md`
- `docs/internal/minuta-aprobacion-tecnica-draft-release-rc1.md`
- `docs/internal/pr-body-draft-release-rc1.md`
- `docs/internal/sca-forensic-diagnostic-2026-02-16.md`

## Licencia

EUPL-1.2. Ver `LICENSE`.
