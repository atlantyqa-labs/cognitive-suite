---
title: Bootstraps por audiencia
description: "Onboarding técnico y operativo adaptado a developer, devsecops, android y stakeholders"
---

# Bootstraps por audiencia

No todos usan la suite con el mismo objetivo. Por eso hay rutas distintas:

## 1. Developer (builder mode)

Enfoque: levantar entorno local completo para iterar rápido en código.

```bash
./scripts/bootstrap.sh --role developer --profile full
source .venv/bin/activate
make build
make run
```

Qué queda listo:

- Dependencias de sistema (Ubuntu/Debian)
- Entorno Python local (`.venv`)
- Estructura de datos (`data/`, `outputs/`)
- Stack Docker para ingesta, pipeline, frontend y gitops

## 2. DevSecOps (guardian mode)

Enfoque: hardening, validación y seguridad de cadena de suministro.

```bash
./scripts/bootstrap.sh --role devsecops --profile full
source .venv/bin/activate
python -m pip_audit -r requirements.txt
```

Qué añade:

- Toolchain base de validación para CI/SCA
- Dependencias para controles de seguridad y cumplimiento
- Preparación para ejecutar `ci-security` localmente

## Perfil VSCode canonizado (early-adopter UX)

Para trabajar con una configuración homogénea de editor en todo el equipo:

- Usa la configuración versionada en `.vscode/`
- Sigue la guía: [VSCode para early-adopters](vscode-tooling-setup.md)

## 3. Early-adopter en Android (Termux)

Enfoque: contribución móvil y operación híbrida (local + host remoto).

```bash
./scripts/bootstrap-android.sh --role developer --profile lite
source .venv-android/bin/activate
```

Notas:

- Perfil `lite` instala lo necesario para documentación, validaciones y CLI.
- Para cargas pesadas, usa `DOCKER_HOST=ssh://...` contra un host Ubuntu.

## 4. Usuario final / Stakeholder (decision mode)

Enfoque: ver valor de negocio sin fricción técnica.

```bash
./scripts/bootstrap-stakeholder.sh --lang es --run-demo
```

Qué ofrece:

- Demo local con imágenes publicadas
- Configuración enfocada en velocidad (`fast mode`)
- Dashboard accesible en `http://localhost:8501`

## Smoke test transversal

Para validar que la capa bootstrap está coherente en la rama:

```bash
./test-bootstrap.sh
```

Este test comprueba:

- Existencia de scripts clave
- Sintaxis shell
- Dry-runs seguros de los tres bootstraps
