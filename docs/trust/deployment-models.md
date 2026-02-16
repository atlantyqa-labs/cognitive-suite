# Modelos de Despliegue

<span class="sovereignty-badge">Arquitectura · Soberanía de Datos</span>

ATLANTYQA se adapta a las necesidades de residencia de datos y nivel de aislamiento de cada organización.

---

## Opciones de Despliegue

<div class="features-grid features-grid--compact" markdown="1">

<div class="feature-card feature-card--accent-top-green" markdown="1">
### 🏠 Local-first / On-prem
Micro-CPDs y nodos edge que ejecutan todos los agentes y guardan los datos sensibles. Control total sin conectividad externa.
</div>

<div class="feature-card feature-card--accent-top-gold" markdown="1">
### ☁️ Híbrido
Tareas menos críticas en cloud certificada, manteniendo data residency para datos sensibles. Lo mejor de ambos mundos.
</div>

<div class="feature-card feature-card--accent-top-navy" markdown="1">
### 🔒 Air-gap
Enclaves completamente aislados para decisiones de alto riesgo. Sin egress externo; builds reproducibles offline.
</div>

</div>

<div class="tactical-container tactical-container--compact" markdown="1">

### Topología de Referencia

```mermaid
graph LR
    Edge[Edge Node] --> MicroCPD[Micro-CPD Local]
    MicroCPD --> Agents[Agentes IA]
    MicroCPD --> Store[Data Store Soberano]
    Agents --> GitOps[GitOps Sync]

    style Edge fill:#f8f9fa,stroke:#cbd5e0,stroke-width:1px,color:#182232
    style MicroCPD fill:#eef9f5,stroke:#37a880,stroke-width:2px,color:#182232
    style Agents fill:#fdf8ef,stroke:#e7ae4c,stroke-width:2px,color:#182232
    style Store fill:#eef9f5,stroke:#37a880,stroke-width:2px,color:#182232
    style GitOps fill:#f8f9fa,stroke:#cbd5e0,stroke-width:1px,color:#182232
```

</div>

!!! info "Estrategia de Cómputo"
    Nuestra estrategia de cómputo detalla qué cargas se mantienen locales y cómo se gestiona la conectividad segura. Consulta la guía pública de [compute strategy](../compute-strategy.md).

<div class="cta-panel">
<p class="cta-panel__text">
¿Necesitas un modelo de despliegue adaptado a tu organización?
</p>
<a href="../trust/overview/" class="btn-primary btn-primary--inline">Ver Trust Pack Completo →</a>
</div>
