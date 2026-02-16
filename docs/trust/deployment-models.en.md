# Deployment Models

<span class="sovereignty-badge">Architecture · Data Sovereignty</span>

ATLANTYQA adapts to the data residency requirements and isolation level of each organization.

---

## Deployment Options

<div class="features-grid features-grid--compact" markdown="1">

<div class="feature-card feature-card--accent-top-green" markdown="1">
### 🏠 Local-first / On-prem
Micro-CPDs and edge nodes that host all agents and keep sensitive data local. Full control without external connectivity.
</div>

<div class="feature-card feature-card--accent-top-gold" markdown="1">
### ☁️ Hybrid
Less critical workloads in certified cloud while preserving data residency for sensitive data. Best of both worlds.
</div>

<div class="feature-card feature-card--accent-top-navy" markdown="1">
### 🔒 Air-gapped
Fully isolated enclaves for high-risk decisions. No external egress; reproducible offline builds.
</div>

</div>

<div class="tactical-container tactical-container--compact" markdown="1">

### Reference Topology

```mermaid
graph LR
    Edge[Edge Node] --> MicroCPD[Micro-CPD Local]
    MicroCPD --> Agents[AI Agents]
    MicroCPD --> Store[Sovereign Data Store]
    Agents --> GitOps[GitOps Sync]

    style Edge fill:#f8f9fa,stroke:#cbd5e0,stroke-width:1px,color:#182232
    style MicroCPD fill:#eef9f5,stroke:#37a880,stroke-width:2px,color:#182232
    style Agents fill:#fdf8ef,stroke:#e7ae4c,stroke-width:2px,color:#182232
    style Store fill:#eef9f5,stroke:#37a880,stroke-width:2px,color:#182232
    style GitOps fill:#f8f9fa,stroke:#cbd5e0,stroke-width:1px,color:#182232
```

</div>

!!! info "Compute Strategy"
    Our compute strategy details which workloads stay local and how secure connectivity is managed. See the public [compute strategy](../compute-strategy.en.md) guide.

<div class="cta-panel">
<p class="cta-panel__text">
Need a deployment model tailored to your organization?
</p>
<a href="../trust/overview/" class="btn-primary btn-primary--inline">View Full Trust Pack →</a>
</div>
