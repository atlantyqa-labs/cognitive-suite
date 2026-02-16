# Interfaz de Usuario Local

<span class="sovereignty-badge">Experiencia · Local-First Segura</span>

La visión de usuario de la **Atlantyqa Cognitive Suite** se centra en una experiencia local-first, segura y orientada a la eficiencia operativa a través de GitOps.

---

## Roles del Sistema

<div class="tactical-container tactical-container--compact" markdown="1">

| Rol | Descripción | Capacidades Clave |
|:---|:---|:---|
| **Administrador Local** | Gestor de infraestructura y políticas | Configuración, gestión de usuarios, auditoría |
| **Analista de Conocimiento** | Usuario principal de análisis | Ingesta, ejecución de análisis, etiquetado cognitivo |
| **Operador GitOps** | Responsable de persistencia | Control de repos, PRs, validación de políticas |
| **Visor Ejecutivo** | Usuario de consulta y reportes | Dashboards críticos y exportación de informes |

</div>

## Flujo de Uso General

<div class="tactical-container" markdown="1">

```mermaid
graph LR
    Auth[🔐 Autenticación] --> Dash[📊 Dashboard]
    Dash --> Ingest[📥 Ingesta]
    Ingest --> Analyze[🧠 Análisis]
    Analyze --> GitOps[🔄 GitOps]

    style Auth fill:#f8f9fa,stroke:#cbd5e0,stroke-width:1px,color:#182232
    style Dash fill:#eef9f5,stroke:#37a880,stroke-width:2px,color:#182232
    style Ingest fill:#fdf8ef,stroke:#e7ae4c,stroke-width:2px,color:#182232
    style Analyze fill:#eef9f5,stroke:#37a880,stroke-width:2px,color:#182232
    style GitOps fill:#f8f9fa,stroke:#cbd5e0,stroke-width:1px,color:#182232
```

</div>

## Requisitos UX No Negociables

<div class="features-grid features-grid--compact" markdown="1">

<div class="feature-card feature-card--accent-left-green" markdown="1">
### 🏠 Modo Offline
Todo el procesamiento ocurre dentro de tu infraestructura. "Tu dato no sale de tu enclave".
</div>

<div class="feature-card feature-card--accent-left-navy" markdown="1">
### 🔄 Feedback GitOps
Estado de sincronización siempre visible para acciones críticas. Transparencia operativa total.
</div>

<div class="feature-card feature-card--accent-left-gold" markdown="1">
### 📋 Control de Versiones
Cada análisis e informe cuenta con trazabilidad total en Git. Historial inmutable.
</div>

</div>
