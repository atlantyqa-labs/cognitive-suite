# Interfaz de Línea de Comandos (CLI)

<span class="sovereignty-badge">Herramientas · Automatización Soberana</span>

Para administradores de sistemas y perfiles técnicos, la **Cognitive Suite** ofrece una potente interfaz de línea de comandos basada en Python para automatización, scripting y gestión del enclave.

---

## Comandos Principales

<div class="features-grid" markdown="1">

<div class="feature-card feature-card--accent-top-green" markdown="1">
### 📥 Ingesta de Documentos
Envía archivos al motor de procesamiento semántico de forma directa.

```bash
atlantyqa ingest --file report_q1.pdf \
  --title "Análisis Trimestral" --tags legal,risk
```
</div>

<div class="feature-card feature-card--accent-top-navy" markdown="1">
### 📋 Monitorización en Tiempo Real
Visualiza los logs del worker local. Ideal para depuración de infraestructura.

```bash
atlantyqa logs --follow
```
</div>

<div class="feature-card feature-card--accent-top-gold" markdown="1">
### 🖥️ Estado del Enclave
Verifica modelos locales y uso de recursos (GPU/RAM) del motor cognitivo.

```bash
atlantyqa status --detailed
```
</div>

<div class="feature-card feature-card--accent-top-green" markdown="1">
### 🔄 Sincronización GitOps
Persiste resultados en el repositorio local y genera el Pull Request correspondiente.

```bash
atlantyqa gitops sync \
  --message "feat: weekly-analysis-sync"
```
</div>

</div>

## Integración con Pipelines

<div class="tactical-container tactical-container--compact" markdown="1">

El CLI está diseñado para scripts de Bash y pipelines CI/CD locales:

```bash
#!/bin/bash
# Script de análisis automático nocturno
FILES=$(ls /data/incoming/*.pdf)

for file in $FILES; do
    atlantyqa ingest --file "$file" --silent
done

atlantyqa gitops sync --message "auto: nightly-batch-process"
```

</div>

!!! tip "Referencia Completa"
    Puedes obtener una lista completa de comandos y opciones ejecutando `atlantyqa --help`.
