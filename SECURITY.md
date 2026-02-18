# Política de Seguridad

Este repositorio sigue una política de divulgación responsable.

## Reporte de vulnerabilidades

Para reportar una vulnerabilidad, escribe a `inno@atlantyqa.org` con:

1. Descripción técnica del hallazgo.
2. Pasos de reproducción.
3. Alcance e impacto potencial.
4. Evidencias mínimas (logs, PoC, versiones afectadas).

## Compromiso de respuesta

- Acuse de recibo inicial: hasta 5 días laborables.
- Clasificación inicial de severidad: hasta 10 días laborables.
- Coordinación de mitigación y divulgación: caso por caso.

## Alcance

- Incluido: código y workflows de este repositorio público.
- Excluido: sistemas internos/no públicos, secretos no publicados, pruebas de ingeniería social y DoS sobre infraestructura externa.

## Divulgación responsable

- No publiques detalles técnicos explotables antes de acordar una ventana de corrección.
- Si reportas de buena fe, no tomaremos acciones legales por pruebas razonables en alcance.

## SCA y seguridad en CI

Este repositorio usa controles automatizados (SBOM, análisis de vulnerabilidades, secret scanning, lint de Dockerfiles y auditoría de dependencias) para reducir riesgo de cadena de suministro.

## Publicación y datos sensibles

El repositorio público está sujeto a `PUBLIC_SCOPE.md` y al guardrail automático `public-scope-guard` para evitar filtraciones de material interno/sensible.
