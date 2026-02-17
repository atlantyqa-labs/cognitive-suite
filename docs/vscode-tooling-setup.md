---
title: VSCode para early-adopters
---

# Perfil canonizado de VSCode

Esta guía define la configuración **estándar y versionada** de VSCode para
early-adopters de `cognitive-suite` (developer y devsecops).

## Qué se canoniza en el repositorio

El workspace queda definido en:

- `.vscode/settings.json`
- `.vscode/extensions.json`
- `.vscode/tasks.json`

Con esto, cualquier miembro del equipo abre el repo y obtiene una base común
("misma imagen y semejanza") para linting, formato, tareas y terminal.

## Configuración clave

### Python

- Interpreter por defecto: `${workspaceFolder}/.venv/bin/python`
- Activación automática del entorno en terminal
- Formateo con Ruff al guardar
- Fixes/imports organizados con acciones explícitas de Ruff

### Shell, YAML y JSON

- Formato on-save para shell (`shell-format`)
- Formato on-save para YAML y JSON
- Perfil de terminal Linux por defecto: `bash -l`

### Higiene del workspace

- Exclusión de caches y entornos (`.venv`, `.venv-android`, `node_modules`)
- Reglas de edición comunes: `rulers` 80/120, trim whitespace, newline final

## Extensiones recomendadas

El archivo `.vscode/extensions.json` recomienda el stack base:

- Python + Pylance + Ruff
- ShellCheck + Shell Format
- YAML
- Docker
- GitHub Actions
- GitLens
- Makefile Tools
- Remote SSH / Dev Containers

## Tareas incluidas (Run Task)

`.vscode/tasks.json` publica tareas operativas reales del repo:

- `Bootstrap: Developer (full)`
- `Bootstrap: DevSecOps (full)`
- `Bootstrap: Stakeholder Demo (es)`
- `Checks: Bootstrap Smoke`
- `Docs: Build Public (strict)`
- `Docs: Build Internal (strict)`
- `Security: pip-audit core`
- `Docker: Build Stack`
- `Run: UI local`

## Onboarding recomendado (Ubuntu/Debian)

1. Ejecuta bootstrap por rol:
   ```bash
   ./scripts/bootstrap.sh --role developer --profile full
   ```
2. Abre el repo con VSCode.
3. Instala las extensiones recomendadas cuando VSCode lo sugiera.
4. Verifica interpreter: `.venv/bin/python`.
5. Ejecuta `Run Task` para validar flujo (`Checks: Bootstrap Smoke`).

## Android early-adopter (Termux)

En Android, el bootstrap genera `.venv-android`. Si trabajas desde VSCode
con host remoto/SSH, usa ese interpreter remoto y mantén estas mismas tareas
como referencia operativa del repositorio.

## Notas de seguridad

- No se almacenan secretos en `.vscode/`.
- Credenciales y tokens deben mantenerse en `.env*` locales no versionados.
