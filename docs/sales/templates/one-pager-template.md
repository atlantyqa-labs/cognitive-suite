<!--
Plantilla reutilizable para convertir cada uno de los one-pagers en assets listos para CRM/documentos de venta.
Rellena los placeholders ({{ }}) con los datos del cliente/actor concreto; mantén el texto institucional intacto.
-->

# {{ actor_name }} · One-Pager ATLANTYQA

<span class="sovereignty-badge">Asset Comercial · {{ segmento }}</span>

> *Elevator Pitch institucional (30s)*
> "{{ elevator_pitch }}"

---

## 1. Problema Estructural

<div class="tactical-container tactical-container--compact" markdown="1">

- Multipolaridad tecnológica y dependencia de hyperscalers
- Regulaciones (AI Act, NIS2, CRA, GDPR) sin capacidad material homogénea
- Riesgo operativo, pérdida de control y talento insuficiente

</div>

## 2. Propuesta ATLANTYQA

<div class="feature-card feature-card--accent-left-green" markdown="1">

{{ sovereign_stack_description }}

```mermaid
graph TD
    A[bot-review.yml] -->|Evidencia| B(Decisiones)
    C[release-*] -->|Builds| D(SBOM)
    E[add_to_project.yml] -->|Trazabilidad| F(Gestión)
    G[metrics/] -->|Scoreboard| H(Dashboard)
```

</div>

## 3. Entregables (cliente específico)

<div class="features-grid features-grid--compact" markdown="1">

<div class="feature-card feature-card--accent-top-green" markdown="1">
### Entregable 1
{{ deliverable_1 }}
</div>

<div class="feature-card feature-card--accent-top-gold" markdown="1">
### Entregable 2
{{ deliverable_2 }}
</div>

<div class="feature-card feature-card--accent-top-navy" markdown="1">
### Entregable 3
{{ deliverable_3 }}
</div>

</div>

## 4. Métricas / Indicadores de Éxito

<div class="tactical-container tactical-container--compact" markdown="1">

- {{ metric_1 }}
- {{ metric_2 }}
- {{ metric_3 }}

</div>

## 5. Argumentario Principal

<div class="mantra-manifesto" markdown="1">
"Reducimos dependencia externa, transformamos el cumplimiento en activo y damos control total sobre datos y automatizaciones."
</div>

## 6. Próximo Paso Recomendado

<div class="tactical-container tactical-container--compact" markdown="1">

- Coordinación con {{ team_onboarding }} (squad/Academy/partner)
- Demo/piloto específico (e.g., {{ pilot_idea }})
- Documentación + pricing (link a `docs/sales/one-pagers.md#{{ actor_anchor }}`)

</div>
